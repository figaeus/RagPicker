module Deactivable

  included do
    field :is_active, type: Boolean, default: true
    field :inactive_reason, type: String
  end

end
