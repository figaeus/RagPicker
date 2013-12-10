require 'spec_helper'

describe User do

  it "fails validations when email is empty" do
    u = User.new
    expect(u.valid?).to be false
  end

  it "fails validation when email is not unique" do
    Fabricate :user
    expect { Fabricate :user }.to raise_error Mongoid::Errors::Validations
  end

end
