require 'spec_helper'

describe Bookmark do

  it "should belong to creator" do
    r = Bookmark.reflect_on_association :creator
    expect(r[:relation]).to be Mongoid::Relations::Referenced::In
    expect(r[:class_name]).to eq "User"
    expect(r[:inverse_of]).to be :created_bookmarks
  end

  
end
