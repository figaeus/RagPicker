require 'spec_helper'

describe Bookmark do

  # Fields :
  it { should have_field(:url).of_type String }
  it { should have_field(:visits).of_type Integer }
  it do
    should have_fields(:publicly_visible, :publicly_annotable)
      .of_type Boolean
  end

  # Relationships :
  it { should have_many :annotations }
  it { should have_many :collaborators }
  it do
    should belong_to(:creator)
      .of_type(User)
      .as_inverse_of(:created_bookmarks)
  end

  # Validations :
  it do
    [:url, :visits].each do |field|
      should validate_presence_of field
    end
  end

end
