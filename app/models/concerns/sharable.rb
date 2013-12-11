module Sharable
  extend ActiveSupport::Concern

  included do
    field :privacy, type: String
    embeds_many :collaborators, as: :target
    validates_inclusion_of :privacy, in: %w{public shared inherited private}
  end
end