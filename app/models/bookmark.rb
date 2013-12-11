class Bookmark
  include Mongoid::Document
  include Sharable

  belongs_to :creator, class_name: "User", inverse_of: :created_bookmarks
  has_many :annotations

  field :url, type: String
  field :visits, type: Integer, default: 0

  validates_presence_of :url, :visits
end
