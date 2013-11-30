require 'rest-client'
require 'json'

class User

  include Mongoid::Document

  field :email, type: String

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
      u = User.where(email: response['email']).first
      if u.nil?
        puts 'Creating user'
        u = User.create email: response['email']
      end
      return u
    end

    nil
  end

end
