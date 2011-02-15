# coding: utf-8

module LazyHighCharts
  module LayoutHelper
    # ActiveSupport::JSON.unquote_hash_key_identifiers = false
    def format_options
      options = []
      @options.each do |k,v|
        options << "#{k}: #{v.to_json}"
      end
      options.join(',')
    end
    private_methods :format_options
    
    def high_chart(placeholder, object  , &block)
      object.html_options.merge!({:id=>placeholder})
      object.options[:chart][:renderTo] = placeholder
      high_graph(placeholder,object , &block).concat(content_tag("div","", object.html_options))
    end

    def high_graph(placeholder, object, &block)
      @options = {
        "chart"       => object.options[:chart],
        "title"       => object.options[:title],
        "legend"      => object.options[:legend],
        "xAxis"       => object.options[:x_axis],
        "yAxis"       => object.options[:y_axis],
        "tooltip"     => object.options[:tooltip],
        "credits"     => object.options[:credits],
        "plotOptions" => object.options[:plot_options],
        "series"      => object.data,
        "subtitle"    => object.options[:subtitle]
      }.reject{|k,v| v.nil?}
      
      graph =<<-EOJS
      <script type="text/javascript">
      jQuery(function() {
            // 1. Define JSON options
            var options = { #{format_options} };

            // 2. Add callbacks (non-JSON compliant)
                                  #{capture(&block) if block_given?}
            // 3. Build the chart
            var chart = new Highcharts.Chart(options);
        });
        </script>
      EOJS
      
      if defined?(raw)
        return raw(graph) 
      else
        return graph
      end
      
    end
  end
end

