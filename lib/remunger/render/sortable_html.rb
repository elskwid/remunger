require "builder"

module Remunger
  module Render
    class SortableHtml

      attr_reader :report, :classes

      # options:
      # :url => /some/url/for/link  # link to put on column
      # :params => {:url_params}    # parameters from url if any
      # :sort => 'column'           # column that is currently sorted
      # :order => 'asc' || 'desc'   # order of the currently sorted field
      def initialize(report, options = {})
        @report = report
        @options = options
        # default url and params options
        @options[:url] ||= '/'
        @options[:params] ||= {}
        set_classes(options[:classes])
      end

      def set_classes(options = nil)
        options = {} if !options
        default = {:table => 'report-table'}
        @classes = default.merge(options)
      end

      def render
        x = Builder::XmlMarkup.new

        x.table(:class => @classes[:table]) do

          x.thead do
            x.tr do
              @report.columns.each do |column|
                # TODO: Should be able to see if a column is 'sortable'
                # Assume all columns are sortable here - for now.
                state = 'unsorted'
                order = 'desc'
                direction_class = ""

                if [column.to_s, @report.column_data_field(column)].include?(@options[:sort])
                  state = "sorted"
                  order = @options[:order] || 'asc'
                  direction_class = "sorted-#{order}"
                end

                new_params = @options[:params].merge({'sort' => @report.column_data_field(column),'order' => (order == 'asc' ? 'desc' : 'asc')})
                x.th(:class => "columnTitle #{state} #{direction_class}") do
                   # x << @report.column_title(column)
                   x << "<a href=\"#{@options[:url]}?#{create_querystring(new_params)}\">#{@report.column_title(column)}</a>"
                 end
              end
            end
          end # x.thead

          x.tbody do
            @report.process_data.each do |row|

              classes = []
              classes << row[:meta][:row_styles]
              classes << 'group' + row[:meta][:group].to_s if row[:meta][:group]
              classes << cycle('even', 'odd')
              classes.compact!

              if row[:meta][:group_header]
                classes << 'groupHeader' + row[:meta][:group_header].to_s
              end

              row_attrib = {}
              row_attrib = {:class => classes.join(' ')} if classes.size > 0

              if row[:meta][:group_header]
                x.thead do
                  x.tr(row_attrib) do
                    header = @report.column_title(row[:meta][:group_name]) + ' : ' + row[:meta][:group_value].to_s
                    x.th(:colspan => @report.columns.size) { x << header }
                  end
                end
              else
                x.tr(row_attrib) do
                  @report.columns.each do |column|

                    cell_attrib = {}
                    if cst = row[:meta][:cell_styles]
                      cst = Item.ensure(cst)
                      if cell_styles = cst[column]
                        cell_attrib = {:class => cell_styles.join(' ')}
                      end
                    end
                    # TODO: Clean this up, I don't like it but it's working
                    # output the cell
                    # x.td(cell_attrib) { x << row[:data][column].to_s }
                    x.td(cell_attrib) do
                      formatter,*args = *@report.column_formatter(column)
                      col_data = row[:data] #[column]
                      if formatter && col_data[column]
                        formatted = if formatter.class == Proc
                          data = col_data.respond_to?(:data) ? col_data.data : col_data
                          formatter.call(data)
                        elsif col_data[column].respond_to? formatter
                          col_data[column].send(formatter, *args)
                        elsif
                          col_data[column].to_s
                        end
                      else
                        formatted = col_data[column].to_s
                      end
                      x << formatted.to_s
                    end

                  end # columns
                end # x.tr
              end

            end # rows

          end # x.tbody

        end # x.table

      end

      def cycle(one, two)
        if @current == one
          @current = two
        else
          @current = one
        end
      end

      def valid?
        @report.is_a? Remunger::Report
      end

      private

      def create_querystring(params={})
        qs = []
        params.each do |k,v|
          qs << "#{k}=#{v}"
        end
        qs.join("&")
      end

    end
  end
end
