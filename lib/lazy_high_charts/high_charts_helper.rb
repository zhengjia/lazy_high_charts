# coding: utf-8

module LazyHighCharts
  module LayoutHelper
    # ActiveSupport::JSON.unquote_hash_key_identifiers = false
    def format_options
      options = []
      @options.each do |k,v|
        options << "#{k}: #{v.to_json}"
      end
      options.join(', ')
    end
    private_methods :format_options
    
    def high_chart(placeholder, object, &block)
      if object
        object.options[:chart][:renderTo] = placeholder
        high_graph(placeholder, object, &block)
      end
    end

    def high_graph(placeholder, object, &block)
      @options = {
        "chart"       => object.options[:chart],
        "title"       => object.options[:title],
        "legend"      => object.options[:legend],
        "xAxis"       => object.options[:xAxis],
        "yAxis"       => object.options[:yAxis],
        "tooltip"     => object.options[:tooltip],
        "credits"     => object.options[:credits],
        "plotOptions" => object.options[:plotOptions],
        "series"      => object.options[:series],
        "subtitle"    => object.options[:subtitle]
      }.reject{|k,v| v.nil?}
      
      graph =<<-EOJS
      <script type="text/javascript">
      jQuery(function() {
            var options = { #{format_options} };
            #{capture(&block) if block_given?}
            var chart = new Highcharts.Chart(options);
        });
        </script>
      EOJS
      
      raw(graph) 
      
    end
  end
end

