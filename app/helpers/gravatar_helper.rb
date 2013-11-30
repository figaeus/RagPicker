require 'digest/md5'

module GravatarHelper
  def profile_image_url(email)
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}?s=30"
  end
end
