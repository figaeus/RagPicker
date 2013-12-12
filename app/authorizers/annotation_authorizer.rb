class AnnotationAuthorizer < ApplicationAuthorizer

  def self.default(able, user)
    user.active?
  end

  def readable_by?(user)
    resource.bookmark.readable_by? user
  end

  %w{updatable sharable administerable}.each do |able|
    is_creator? user
  end

  def deletable_by?(user)
    is_creator?(user) or
      resource.bookmark.administerable_by? user
  end

  %w{annotable}.each do |able|
    define_method "#{able}_by?" do |user|
      false
    end
  end

  def repliable_by?(user)
    resource.bookmark.editable_by? user
  end

end
