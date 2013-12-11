require 'rest-client'
require 'json'

class User

  include Mongoid::Document

  field :email, type: String
  has_many :created_bookmarks, class_name: "Bookmark", inverse_of: :creator
  has_many :created_annotations, class_name: "Annotation", inverse_of: :creator

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email,
    with: /\A[_a-z0-9\-\+]+(\.[_a-z0-9\-]+)*@[a-z0-9\-]+(\.[a-z0-9]+)*(\.[a-z]{2,})\z/i

  def self.find_by_email(email)
    User.where(email: email).first
  end

  def self.authenticate(assertion)
    assertion_params = {
      assertion: assertion,
      audience: PERSONA_CONFIG['audience']
    }
    request = RestClient::Resource.new(
        PERSONA_CONFIG['server'],
        verify_ssl: true
      ).post(assertion_params)
    response = JSON.parse(request)

    if response['status'] == 'okay'
      u = User.find_by_email response['email']
      if u.nil?
        u = User.create email: response['email']
      end
      return u
    end

    nil
  end

end
