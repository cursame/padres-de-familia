require 'rails_helper'

RSpec.describe V1::InstitutionsController, type: :controller do
  before(:each) { api_authenticate_header create(:user) }

  describe "GET #show" do
    before(:each) do
      @institution = create(:institution)
      get :show, id: @institution.id
    end

    it "returns the information about a institution on a hash" do
      user_response = json_response
      expect(user_response[:name]).to eql @institution.name
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @institution_attributes = attributes_for :institution
        post :create, institution: @institution_attributes
      end

      it "renders the json representation for the institution record just created" do
        institution_response = json_response
        expect(institution_response[:name]).to eql @institution_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @invalid_institution_attributes = { name: nil }
        post :create, institution: @invalid_institution_attributes
      end

      it "renders an errors json" do
        institution_response = json_response
        expect(institution_response).to have_key(:errors)
      end

      it "renders the json errors on why the institution could not be created" do
        institution_response = json_response
        expect(institution_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @institution = create(:institution)
        patch :update, { id: @institution.id,
                         institution: { name: 'newname' } }
      end

      it "renders the json representation for the updated institution" do
        institution_response = json_response
        expect(institution_response[:name]).to eql 'newname'
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        @institution = create(:institution)
        patch :update, { id: @institution.id,
                         institution: { name: nil } }
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the institution could not be updated" do
        institution_response = json_response
        expect(institution_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @institution = create(:institution)
      delete :destroy, id: @institution.id
    end

    it { should respond_with 204 }
  end
end
