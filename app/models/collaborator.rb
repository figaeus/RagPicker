class Collaborator
  include Mongoid::Document

  belongs_to :target, polymorphic: true
  belongs_to :user

  field :name, type: String
  field :can_read, type: String
  field :can_edit, type: String
  field :is_admin, type: String

  validates_presence_of :name
  validates_presence_of :user

  validates_uniqueness_of :user_id
end
