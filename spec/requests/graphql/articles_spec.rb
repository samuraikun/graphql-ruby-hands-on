require "rails_helper"

RSpec.describe "Articles", type: :request do
  before "create test data" do
    @user = create(:user)
    create(:article, user: @user, title: "test")
  end

  describe "Query Article" do
    it "fetch article include user, comments, tags" do
      query_string = <<~QUERY
        query($userId: ID!) {
          articles(userId: $userId) {
            title
            user {
              username
            }
            comments {
              body
              user {
                username
              }
            }
            tags {
              name
            }
          }
        }
      QUERY

      post "/graphql", params: { query: query_string, variables: { userId: @user.id } }

      json = JSON.parse(response.body)
      binding.irb
      expect(json["data"]["articles"][0]["title"]).to eq "test"
    end
  end
end
