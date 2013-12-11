class Annotation
  include Mongoid::Document

  belongs_to :bookmark
  belongs_to :creator, class_name: "User", inverse_of: :created_annotations

  field :kind, type: String
  field :content, type: String

  embeds_many :collaborators, as: :target

  validates_presence_of :content, :bookmark, :creator, :kind, :content
  validates_inclusion_of :kind, in: ['floating', 'margin', 'reply', 'highlight']

end
