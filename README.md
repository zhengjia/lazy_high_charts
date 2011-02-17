This is forked from the original gem_support branch.

In this fork:

1. All the default options are removed. Those default options in the original library can really make you lazy, but it often gives you surprising result if you don't redefine it. Besides, the HTML and CSS default options should really be handled separately. You have more control over what you need with this fork. 

2. You are able to append additional options. It makes it easier to have a template chart object and construct it for different scenarios. For example, you want to show temperatures for different periods of time. You can define a template like this:

template = LazyHighCharts::HighChart.new do |f|
  f.xAxis(:type => "datetime")
  f.yAxis(:title => { :text => "Degrees" } )
  f.series(:pointInterval => 86400000 )
end

You can append the data later to the template like this:

template.tap do |f|
  f.title(:text => "Week to Date Smokes")
  f.series({:pointStart => Time.now.beginning_of_week.to_i*1000, :data => @week_data}, :merge )
end

Notice the :merge option, which takes the hash and merge it to the first element of the array options[:series][:data]

If you need to add a second series of data, just don't pass the :merge option, and it will be appended to the data array, like this:

template.tap do |f|
  f.series(:pointInterval => 86400000, :pointStart => Time.now.beginning_of_last_week.to_i*1000, :data => @last_week_data )
end

3. You only need to pass in one optional parameter to the initializer. So you can do:

LazyHighCharts::HighChart.new do |f|
  ...
end

And by default the highchart js library will use line to plot.

You can also pass in the optional parameter to specify the type of graph, like:

LazyHighCharts::HighChart.new('pie') do |f|
  ...
end

The plot options are documented on highcharts website.

4. Rename options[:x_axis] and options[:y_axis] to options[:xAxis] and options[:xYxis], and options[:plot_options] to options[:plotOptions] to make it consistent with highcharts.

5. Generators are removed. You can download highcharts and include it in views yourself.


LazyHighCharts
=======
 update(Dec 4,2010)

- Test Environment
  ruby 1.9.2p0 (2010-08-18 revision 29036) [x86_64-darwin10.4.0]
  rspec 2.0
  rails 3.0.1
- Result(autotest)
Finished in 0.01502 seconds
9 examples, 0 failures
  
Attention:
this gem Only support Rails 3.x

Usage
=======
 In your Gemfile, add this line:
	gem 'lazy_high_charts'

 Usage in Controller:
  
     @h = LazyHighCharts::HighChart.new('graph') do |f|
        f.series(:name=>'John', :data=>[3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9])
        f.series(:name=>'Jane', :data=> [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] )
      end
 

  Without overriding entire option , (only change a specific option index):  
 
     @h = LazyHighCharts::HighChart.new('graph') do |f|
      .....
          f.options[:chart][:defaultSeriesType] = "area"
          f.options[:chart][:inverted] = true
          f.options[:legend][:layout] = "horizontal"
          f.options[:x_axis][:categories] = ["uno" ,"dos" , "tres" , "cuatro"]
     ......

  Overriding entire option: 

     @h = LazyHighCharts::HighChart.new('graph') do |f|
       .....
          f.x_axis(:categories => @days.reverse! , :labels=>{:rotation=>-45 , :align => 'right'})
          f.chart({:defaultSeriesType=>"spline" , :renderTo => "myRenderArea" , :inverted => true})
       .....


  Usage in layout:
      
  <%= javascript_include_tag 'highcharts' %>
  <!--[if IE]>
  <%= javascript_include_tag 'excanvas.compiled' %>
  <![endif]-->
      
  Usage in view:
  
    <%= high_chart("my_id", @h) %>
    
  Passing formatting options in the view to the helper block , because all the helper options declared in the controller are converted in strict/valid json (quoted key);  so we need to extend the json object with some js.
  
      <% high_chart("my_id", @h) do |c| %>
         	<%= "options.tooltip.formatter = function() { return '<b>HEY!!!'+ this.series.name +'</b><br/>'+ this.x +': '+ this.y +' units';}" %>
         	<%= "options.xAxis.labels.formatter = function() { return 'ho';}" %>
         	<%= "options.yAxis.labels.formatter = function() { return 'hey';}" %>
       <%end %> 
      


  Option reference:

     http://www.highcharts.com/ref/



    
Contributors
=======
	LazyHighCharts gem is maintained by "Deshi Xiao":https://github.com/xiaods
  git shortlog -n -s --no-merges


Copyright (c) 2010 Miguel Michelson Martinez, released under the MIT license
