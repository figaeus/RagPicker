require 'spec_helper'

describe Annotation do

  it "should belong to creator" do
    r = Annotation.reflect_on_association :creator
    expect(r[:relation]).to be Mongoid::Relations::Referenced::In
    expect(r[:class_name]).to eq "User"
    expect(r[:inverse_of]).to be :created_annotations
  end

  it "should have field kind of type String" do
    expect(Annotation.fields['kind'].options[:type]).to be String
  end

  it "should have field content of type String" do
    expect(Annotation.fields['content'].options[:type]).to be String
  end

end
