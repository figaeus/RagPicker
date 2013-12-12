class BookmarkAuthorizer < ApplicationAuthorizer

  def self.default(able, user)
    user.active?
  end

  def readable_by?(user)
    case resource.privacy
    when 'public'
      true
    when 'private'
      resource.creator_id == user._id
    when 'shared'
      is_creator?(user) or not
        resource.collaborators.find_by(
          user_id: user._id,
          can_read: true
        ).nil?
    else
      false
    end
  end

  def annotable_by?(user)
    is_creator?(user) or not
      resource.collaborators.find_by(
        user_id: user._id,
        can_edit: true
      )
  end

  %w{updatable repliable}.each do |able|
    define_method "#{able}_by?" do |user|
      false
    end
  end

  %w{deletable sharable}.each do |able|
    define_method "#{able}_by?" do |user|
      is_creator?(user) or not
        resource.collaborators.find_by(
          user_id: user._id,
          is_admin: true
        ).nil?
    end
  end

end
