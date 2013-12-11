require 'spec_helper'

describe User do

  it "fails validations when email is empty" do
    u = User.new
    expect(u.valid?).to be false
    expect(u.errors[:email]).to include "can't be blank"
  end

  it "fails validation when email is not valid" do
    expect do
      Fabricate :user, email: "xyz@xxx"
    end.to raise_error Mongoid::Errors::Validations, /Email is invalid/
  end

  it "allows correctly formatted email addresses" do
    expect(Fabricate(:user).valid?).to be true
  end

  it "fails validation when email is not unique" do
    Fabricate :user
    expect do
      Fabricate :user
    end.to raise_error Mongoid::Errors::Validations, /Email is already taken/
  end

  it "should have many created_bookmarks" do
    r = User.reflect_on_association(:created_bookmarks)
    expect(r[:relation]).to be Mongoid::Relations::Referenced::Many
    expect(r[:class_name]).to eq "Bookmark"
    expect(r[:inverse_of]).to be :creator
  end

  it "should have many created_annotations" do
    r = User.reflect_on_association(:created_annotations)
    expect(r[:relation]).to be Mongoid::Relations::Referenced::Many
    expect(r[:class_name]).to eq "Annotation"
    expect(r[:inverse_of]).to be :creator
  end

  describe ".authenticate" do

    before :each do
      WebMock.disable_net_connect!(:allow_localhost => true)
    end

    it "should send a post request to Mozilla Persona authentication server" do
      stub = stub_request(:post, PERSONA_CONFIG['server'])
        .to_return(:body => {status: 'okay'}.to_json)
      allow(User)
        .to receive(:find_by_email)
          .and_return(User.new)
      User.authenticate 'dummy assertion'
      expect(stub)
        .to have_been_made.times(1)
    end

    context "remote authentication success" do

      before :each do
        stub_request(:post, PERSONA_CONFIG['server'])
          .to_return(:body => {status: 'okay'}.to_json)
      end

      context "user exists" do

        it "should return existing user" do
          u = User.new
          allow(User)
            .to receive(:find_by_email)
              .and_return(u)
          expect(User.authenticate 'dummy assertion')
            .to be u
        end

      end

      context "user is new" do

        it "should create new user" do
          u = User.new
          allow(User)
            .to receive(:find_by_email)
              .and_return(nil)
          allow(User)
            .to receive(:create)
            .and_return(u)
          expect(User.authenticate 'dummy assertion')
            .to be u
        end

      end

    end

    context "remote authentication failure" do

      before :each do
        stub_request(:post, PERSONA_CONFIG['server'])
          .to_return(:body => {status: 'error'}.to_json)
      end

      it "should return nil" do
        expect(User.authenticate 'dummy assertion')
          .to be_nil
      end

    end

  end

end
