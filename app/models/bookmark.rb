class Bookmark
  include Mongoid::Document

  # privacy field interpretation:
  #    - public : Anyone can read,
  #               Anyone can annotate
  #               creator / collaborators with edit permissions can edit
  #    - private : creator can 
  include Sharable
  include Deactivable

  belongs_to :creator, class_name: "User", inverse_of: :created_bookmarks
  has_many :annotations

  field :url, type: String
  field :visits, type: Integer, default: 0
  field :is_active, type: String
  field :inactive_reason, type: String

  validates_presence_of :url, :visits
end
