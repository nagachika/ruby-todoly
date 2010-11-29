require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Todoly" do
  it "can required" do
    defined?(Todoly).should be_eql("constant")
  end
end
