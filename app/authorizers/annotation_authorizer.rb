class AnnotationAuthorizer < ApplicationAuthorizer

  def has_collaborator?(user, permission)
    obj = {}
    obj[permission] = true
    obj[:user_id] = user._id

    not resource.collaborators.find_by(obj).nil?
  end

  def self.default(able, user)
    user.active?
  end

  def readable_by?(user)
    case resource.privacy
    when 'public'
      true
    when 'private'
      is_creator? user
    when 'shared'
      is_creator?(user) or
        has_collaborator?(user, :can_read)
    when 'inherited'
      is_creator?(user) or
        has_collaborator?(user, :can_read) or
        resource.bookmark.readable_by? user
    end
  end

  def updatable_by?(user)
    
  end

end
