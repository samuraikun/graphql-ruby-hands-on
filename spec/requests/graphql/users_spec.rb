# spec/requests/users_spec.rb
require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "POST /graphql" do
    it "fetch user" do
      query_string = <<~QUERY
        query($id: ID!) {
          user(id: $id) {
            id
            email
            firstName
            lastName
            username
            postalCode
            address
            phone
          }
        }
      QUERY

      post "/graphql", params: { query: query_string, variables: { id: user.id } }

      json = JSON.parse(response.body)
      expect(json["data"]["user"]["id"]).to eq user.id.to_s
      expect(json["data"]["user"]["email"]).to eq user.email
      expect(json["data"]["user"]["firstName"]).to eq user.first_name
      expect(json["data"]["user"]["lastName"]).to eq user.last_name
      expect(json["data"]["user"]["username"]).to eq user.username
      expect(json["data"]["user"]["postalCode"]).to eq user.postal_code
      expect(json["data"]["user"]["address"]).to eq user.address
      expect(json["data"]["user"]["phone"]).to eq user.phone
    end

    it "fetch all users" do
      query_string = <<~QUERY
        query {
          users {
            id
          }
        }
      QUERY

      post "/graphql", params: { query: query_string, variables: { id: user.id } }

      json = JSON.parse(response.body)
      expect(json["data"]["users"].count).to eq User.count
    end

    it "create user" do
      params = {
        email: "john@example.com",
        password: "password",
        firstName: "John",
        lastName: "Doe",
        username: "johndoe",
        postalCode: "123-4567",
        address: "Tokyo, Japan",
        phone: "03-1234-5678",
      }
      query_string = <<~QUERY
        mutation {
          createUser(
            email: "#{params[:email]}"
            password: "#{params[:password]}"
            firstName: "#{params[:firstName]}"
            lastName: "#{params[:lastName]}"
            username: "#{params[:username]}"
            postalCode: "#{params[:postalCode]}"
            address: "#{params[:address]}"
            phone: "#{params[:phone]}"
          ) {
            id
            email
            firstName
            lastName
            username
            postalCode
            address
            phone
          }
        }
      QUERY

      post "/graphql", params: { query: query_string }

      json = JSON.parse(response.body)
      user = json["data"]["createUser"]
      expect(user["email"]).to eq params[:email]
      expect(user["firstName"]).to eq params[:firstName]
      expect(user["lastName"]).to eq params[:lastName]
      expect(user["username"]).to eq params[:username]
      expect(user["postalCode"]).to eq params[:postalCode]
      expect(user["address"]).to eq params[:address]
      expect(user["phone"]).to eq params[:phone]
    end
  end
end
