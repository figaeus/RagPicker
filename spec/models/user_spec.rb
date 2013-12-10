require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"

  it "fails validations when email is empty" do
    u = User.new
    expect(u.valid?).to be false
  end

  it "fails validation when email is not unique" do
    u = Fabricate :user
    u.save
    u = Fabricate :user
    expect(u.valid?).to be false
  end

end
