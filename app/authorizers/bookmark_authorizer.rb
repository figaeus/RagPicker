class BookmarkAuthorizer < ApplicationAuthorizer

  def self.default(able, user)
    user.active?
  end

  def bookmark
    resource
  end

  def self.creatable_by?(user)
    default
  end

  def readable_by?(user)
    bookmark.publicly_visible or
      not bookmark.collaborators.find_by(
        user_id: user._id,
        can_read: true
      ).nil?
  end

  def annotable_by?(user)
    bookmark.publicly_annotable or
      not resource.collaborators.find_by(
        user_id: user._id,
        can_edit: true
      ).nil?
  end

  %w{updatable repliable}.each do |able|
    define_method "#{able}_by?" do |user|
      false
    end
  end

  %w{deletable sharable administerable}.each do |able|
    define_method "#{able}_by?" do |user|
        not resource.collaborators.find_by(
          user_id: user._id,
          is_admin: true
        ).nil?
    end
  end

end
