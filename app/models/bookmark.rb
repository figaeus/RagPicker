class Bookmark
  include Mongoid::Document

  belongs_to :creator, class_name: "User", inverse_of: :created_bookmarks
  has_many :annotations

  field :url, type: String
  field :visits, type: Integer
end
