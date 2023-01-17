require "rails_helper"

RSpec.describe "Articles", type: :request do
  before "create test data" do
    @user = create(:user)
    @article = create(:article, user: @user, title: "test")
  end

  describe "Query Article" do
    it "fetch article include user, comments(belonging resource & has_many resources)" do
      query_string = <<~QUERY
        query($userId: ID!) {
          articles(userId: $userId) {
            title
            user {
              username
            }
            comments {
              body
            }
          }
        }
      QUERY

      post "/graphql", params: { query: query_string, variables: { userId: @user.id } }

      json = JSON.parse(response.body)
      articles = json["data"]["articles"]
      expect(articles[0]["title"]).to eq "test"
      expect(articles[0]["comments"][0]["body"]).to eq @article.comments.first.body
    end
  end
end
