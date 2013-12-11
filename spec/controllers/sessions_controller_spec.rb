require 'spec_helper'

describe SessionsController do

  describe 'POST #create' do

    context 'authentication succeeds' do

      before :each do
        allow(User)
          .to receive(:authenticate)
          .and_return User.new
      end

      it 'responds successfully with 200 status code' do
        post :create
        expect(response.status).to be 200
      end
    end

    context 'authentication fails' do

      before :each do
        allow(User)
          .to receive(:authenticate)
            .and_return nil
      end

      it 'responds with 406 error code' do
        post :create
        expect(response.status).to be 406
      end
    end

  end

  
end
