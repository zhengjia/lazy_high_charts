require File.dirname(__FILE__) + '/spec_helper'

describe "HighChart" do
  
  before(:each) do
    @data         = [[1,15], [2,30], [4,40]]
    @placeholder  = "placeholder"
    @options      = {:bars => {:show => true}}
    @flot         = LazyHighCharts::HighChart.new(@placeholder) {|chart| chart.options = @options }
  end
    
  it "should take have a default graph_type argument" do
     lc = LazyHighCharts::HighChart.new
     lc.options[:chart].should == {}
  end
   
  it "should take an optional graph_type argument" do
     lc = LazyHighCharts::HighChart.new('pie')
     lc.options[:chart].should == {:defaultSeriesType => 'pie'}
  end

  it "should take a block setting attributes" do
   lc = LazyHighCharts::HighChart.new {|f| f.title(:text => "ttt")  }
   lc.options[:title].should == { :text => "ttt"}
  end
  
  it "should be able to merge options to the first set of data" do
    lc = LazyHighCharts::HighChart.new {|f| f.series(:pointStart => "x")  }
    lc.series({:pointInterval => 86400000}, :merge)
    lc.options[:series].should == [{ :pointStart => "x", :pointInterval => 86400000 }]
  end
  
  it "should be able to override options on the first set of data" do
    lc = LazyHighCharts::HighChart.new {|f| f.series(:pointStart => "x")  }
    lc.series({:pointStart => "y"}, :merge)
    lc.options[:series].should == [{ :pointStart => "y" }]
  end
  
  it "should be able to add to sets of data" do
    lc = LazyHighCharts::HighChart.new {|f| f.series(:pointStart => "x")  }
    lc.series({:pointStart => "y"})
    lc.options[:series].should == [{ :pointStart => "x" }, {:pointStart => "y"} ]
  end

end