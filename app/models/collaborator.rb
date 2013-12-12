class Collaborator
  include Mongoid::Document

  belongs_to :target, polymorphic: true
  belongs_to :user

  before_create :autofill_name, :autofill_missing_permissions

  field :name, type: String
  field :can_read, type: String
  field :can_edit, type: String
  field :is_admin, type: String, default: false

  validates_presence_of :name, :can_read, :can_edit, :is_admin
  validates_uniqueness_of :user_id

  validates_inclusion_of :can_read,
    in: [true],
    if: ->(o) { o.can_edit }

  validates_inclusion_of :can_edit,
    in: [true],
    if: ->(o) { o.is_admin }

  def autofill_name
    name = user.name
  end

  def autofill_missing_permissions
    can_edit = is_admin if can_edit.nil?
    can_read = can_edit if can_read.nil?
  end

end
