module Sharable

  extend ActiveSupport::Concern
  include Authority::Abilities

  included do
    field :privacy, type: String
    has_many :collaborators, as: :target
    validates_inclusion_of :privacy, in: %w{public shared inherited private}
  end

  def active?
    is_active == true
  end

end
