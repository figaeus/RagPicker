require 'spec_helper'

describe Bookmark do

  it "has field url of type String" do
    field = Bookmark.fields['url']
    expect(field).to be_truthy
    expect(field.options[:type]).to be String
  end

  it "has field visits of type Integer" do
    field = Bookmark.fields['visits']
    expect(field).to be_truthy
    expect(field.options[:type]).to be Integer
  end

  it "belongs to creator" do
    r = Bookmark.reflect_on_association :creator
    expect(r[:relation]).to be Mongoid::Relations::Referenced::In
    expect(r[:class_name]).to eq "User"
    expect(r[:inverse_of]).to be :created_bookmarks
  end

  it "has many annotations" do
    r = Bookmark.reflect_on_association :annotations
    expect(r[:relation]).to be Mongoid::Relations::Referenced::Many
  end

  it "has many collaborators" do
    r = Bookmark.reflect_on_association :collaborators
    expect(r[:relation]).to be Mongoid::Relations::Referenced::Many
  end
end
