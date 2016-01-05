require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  before(:each) { api_authenticate_header create(:user) }

  describe "GET #index" do
    before(:each) do
      @new_institution = create(:institution)
      @admin = create(:admin, institution_id: @new_institution.id)
      @teacher = create(:teacher, institution_id: @new_institution.id)
      @legal_guardian = create(:legal_guardian, institution_id: @new_institution.id)
      @student = create(:student, institution_id: @new_institution.id)
    end

    shared_examples 'has 200 status' do
      it { should respond_with 200 }
    end

    context 'scope has role admin' do
      before(:each) do
        get :index, has_role: 'admin'
      end

      it 'renders the json representation for the users with admin role' do
        users_response = json_response
        @user = User.find(users_response.first[:id])
        expect(users_response.count).to eql 1
        expect(@user.has_role? :admin).to be true
      end

      it_behaves_like 'has 200 status'
    end

    context 'scope has role teacher' do
      before(:each) do
        get :index, has_role: 'teacher'
      end

      it 'renders the json representation for the users with teacher role' do
        users_response = json_response
        @user = User.find(users_response.first[:id])
        expect(users_response.count).to eql 1
        expect(@user.has_role? :teacher).to be true
      end

      it_behaves_like 'has 200 status'
    end

    context 'scope has role legal_guardian' do
      before(:each) do
        get :index, has_role: 'legal_guardian'
      end

      it 'renders the json representation for the users with legal_guardian role' do
        users_response = json_response
        @user = User.find(users_response.first[:id])
        expect(users_response.count).to eql 1
        expect(@user.has_role? :legal_guardian).to be true
      end

      it_behaves_like 'has 200 status'
    end

    context 'scope has role student' do
      before(:each) do
        get :index, has_role: 'student'
      end

      it 'renders the json representation for the users with student role' do
        users_response = json_response
        @user = User.find(users_response.first[:id])
        expect(users_response.count).to eql 1
        expect(@user.has_role? :student).to be true
      end

      it_behaves_like 'has 200 status'
    end

    context 'scope institution' do
      before(:each) do
        get :index, institution: @new_institution.id
      end

      it 'renders the json representation for the users in an institution' do
        users_response = json_response
        expect(users_response.count).to eql 4
      end

      it_behaves_like 'has 200 status'
    end
  end

  describe "GET #show" do
    before(:each) do
      @user = create(:user)
      get :show, id: @user.id
    end

    it "returns the information about a user on a hash" do
      user_response = json_response
      expect(user_response[:email]).to eql @user.email
      expect(user_response[:name]).to eql @user.name
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @user_attributes = attributes_for :user
        @user_attributes[:institution_id] = Institution.last.id
        post :create, user: @user_attributes
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @invalid_user_attributes = attributes_for :user
        @invalid_user_attributes[:email] = nil
        post :create, user: @invalid_user_attributes
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @user = create(:user)
        patch :update, { id: @user.id,
                         user: { email: "newmail@example.com" } }
      end

      it "renders the json representation for the updated user" do
        user_response = json_response
        expect(user_response[:email]).to eql "newmail@example.com"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        @user = create(:user)
        patch :update, { id: @user.id,
                         user: { email: "bademail.com" } }
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be updated" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is not an email"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = create(:user)
      delete :destroy, id: @user.id
    end

    it { should respond_with 204 }
  end
end
