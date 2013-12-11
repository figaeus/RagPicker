class Collaborator
  include Mongoid::Document
  include Sharable

  embedded_in :target, polymorphic: true
  belongs_to :user

  field :name, type: String
end
