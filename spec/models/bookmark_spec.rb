require 'spec_helper'

describe Bookmark do

  it "should belong to creator" do
    r = Bookmark.reflect_on_association :creator
    expect(r[:relation]).to be Mongoid::Relations::Referenced::In
    expect(r[:class_name]).to eq "User"
    expect(r[:inverse_of]).to be :created_bookmarks
  end

  it "should have field url of type String" do
    field = Bookmark.fields['url']
    expect(field).to be_truthy
    expect(field.options[:type]).to be String
  end

  it "should have field visits of type Integer" do
    field = Bookmark.fields['visits']
    expect(field).to be_truthy
    expect(field.options[:type]).to be Integer
  end

end
