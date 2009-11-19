require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do
  before(:each) do
    @valid_attributes = {
      :image_file_name => "value for file_name",
      :image_content_type => "value for content_type",
      :image_file_size => 1,
      :image_updated_at => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    Photo.create!(@valid_attributes)
  end

end
