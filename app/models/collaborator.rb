class Collaborator
  include Mongoid::Document

  embedded_in :target, polymorphic: true
  belongs_to :user

  field :name, type: String

  validates_presence_of :name
  validates_presence_of :user

  validates_uniqueness_of :user_id
end
