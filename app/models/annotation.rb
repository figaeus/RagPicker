class Annotation
  include Mongoid::Document

  belongs_to :bookmark
  belongs_to :creator, class_name: "User", inverse_of: :created_comments

  field :kind, type: String
  field :content, type: String

end
