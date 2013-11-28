require 'spec_helper'

describe HomeController do

  describe 'GET #index' do

    it 'responds successfully with 200 status code' do
      get :index
      expect(response).to be_success
      expect(response.status).to be 200
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template 'index'
    end

  end

end
