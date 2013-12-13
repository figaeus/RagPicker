require 'spec_helper'

describe Bookmark do

  it { should have_field(:url).of_type String }
  it { should have_field(:visits).of_type Integer }
  it { should have_many :annotations }
  it { should have_many :collaborators }
  it {
    should belong_to(:creator)
      .of_type(User)
      .as_inverse_of(:created_bookmarks)
  }

end
