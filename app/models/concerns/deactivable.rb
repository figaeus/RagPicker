module Deactivable

  included do
    field :is_active, type: Boolean, default: true
    field :inactive_reason, type: String

    scope :active, -> where is_active: false
    scope :inactive_due_to, ->(r) where is_active: false, inactive_reason: r
  end

end
