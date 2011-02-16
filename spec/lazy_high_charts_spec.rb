# coding: utf-8
require File.dirname(__FILE__) + '/spec_helper'
require 'pp'

describe HighChartsHelper do  
  include LazyHighCharts::LayoutHelper

  before(:each) do
    @placeholder = "placeholder"
    @chart        = LazyHighCharts::HighChart.new
    @data        = "data"
    @options     = "options"
  end
  
  describe "high_chart_helper" do
    it "should return a script" do
      high_chart(@placeholder, @chart).should have_selector('script')
    end
    
    it "should not render if LazyHighCharts::HighChart.new is not avaiable" do
      high_chart(@placeholder, nil).should be_nil
    end
  end
   
  describe "high_chart_graph" do
    describe "ready function" do
      it "should be a javascript script" do
        high_chart(@placeholder, @chart).should have_selector('script', :type => 'text/javascript')
        high_chart(@placeholder, @chart).should match(/\}\s*\)\s*;/)
      end

      it "should generate generate ready function (no conflict with prototype)" do
        high_chart(@placeholder, @chart).should match(/jQuery\(function\(\)\s*\{/)
      end
    end
    describe "initialize HighChart" do
      it "should set Chart data" do
        high_chart(@placeholder, @chart).should match(/var\s+chart\s+=\s+new\s+Highcharts.Chart/)
      end       

      it "should set chart renderTo" do  
        high_chart(@placeholder, @chart).should match(/\"renderTo\":\"placeholder\"/)
      end

    end
  end
  

end
