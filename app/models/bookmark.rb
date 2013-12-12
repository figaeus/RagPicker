class Bookmark
  include Mongoid::Document
  before_create :share_with_creator

  include Deactivable

  belongs_to :creator, class_name: "User", inverse_of: :created_bookmarks
  has_many :annotations
  has_many :collaborators, as: :target

  field :url, type: String
  field :visits, type: Integer, default: 0
  field :publicly_visible, default: false
  field :publicly_annotable, default: false

  validates_presence_of :url, :visits

  def share_with_creator
    collaborators << Collaborator.create!(user: creator, is_admin: true)
  end
end
