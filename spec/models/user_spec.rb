require 'spec_helper'

describe User do

  it "fails validations when email is empty" do
    u = User.new
    expect(u.valid?).to be false
    expect(u.errors[:email]).to include "can't be blank"
  end

  it "fails validation when email is not valid" do
    expect do
      Fabricate :user, email: "xyz@xxx"
    end.to raise_error Mongoid::Errors::Validations, /Email is invalid/
  end

  it "allows correctly formatted email addresses" do
    expect(Fabricate(:user).valid?).to be true
  end

  it "fails validation when email is not unique" do
    Fabricate :user
    expect do
      Fabricate :user
    end.to raise_error Mongoid::Errors::Validations, /Email is already taken/
  end

  it "should have many created_bookmarks" do
    r = User.reflect_on_association(:created_bookmarks)
    expect(r[:relation]).to be Mongoid::Relations::Referenced::Many
    expect(r[:class_name]).to eq "Bookmark"
    expect(r[:inverse_of]).to be :creator
  end

  it "should have many created_annotations" do
    r = User.reflect_on_association(:created_annotations)
    expect(r[:relation]).to be Mongoid::Relations::Referenced::Many
    expect(r[:class_name]).to eq "Annotation"
    expect(r[:inverse_of]).to be :creator
  end

end
