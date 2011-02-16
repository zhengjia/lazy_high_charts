module LazyHighCharts
  class HighChart

    attr_accessor :options

    def initialize(graph_type = nil )
      @options = {}
      self.tap do |high_chart|
        high_chart.chart
        high_chart.chart( :defaultSeriesType => graph_type ) if graph_type
        yield high_chart if block_given?
      end
    end
    
    def series(value, option = nil )
      @options[:series] ||= []
      if option == :merge
        @options[:series].first.merge!(value)
      else
        @options[:series] << value
      end
    end
    
    def method_missing(meth, value = {})
      merge_options meth, value
    end

    private

    def merge_options(name, opts)
      existing_value = @options[name] || {}
      @options.merge!  name => existing_value.merge!(opts)
    end

  end
end
