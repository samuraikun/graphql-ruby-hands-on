require 'rails_helper'

RSpec.describe "GraphQL queries", type: :request do
  describe "user query" do
    let(:user) { create(:user) }
    let(:query) do
      <<~GQL
        query($id: ID!) {
          user(id: $id) {
            id
            name
            email
          }
        }
      GQL
    end

    it "returns the user with the specified ID" do
      post '/graphql', params: { query: query, variables: { id: user.id } }
      json = JSON.parse(response.body)
      data = json['data']['user']
      expect(data).to include(
        'id' => user.id.to_s,
        'name' => user.name,
        'email' => user.email
      )
    end
  end

  describe "users query" do
    let!(:users) { create_list(:user, 3) }
    let(:query) do
      <<~GQL
        query {
          users {
            id
            name
            email
          }
        }
      GQL
    end

    it "returns all users" do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['users']
      expect(data.size).to eq(users.size)
      data.each_with_index do |user_data, i|
        expect(user_data).to include(
          'id' => users[i].id.to_s,
          'name' => users[i].name,
          'email' => users[i].email
        )
      end
    end
  end

  describe "article query" do
    let(:article) { create(:article) }
    let(:query) do
      <<~GQL
        query {
          article(id: #{article.id}) {
            id
            title
            body
          }
        }
      GQL
    end

    it "returns the article with the specified ID" do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['article']
      expect(data).to include(
        'id' => article.id.to_s,
        'title' => article.title,
        'body' => article.body
      )
    end
  end

  describe "articles query" do
    let!(:articles) { create_list(:article, 3) }
    let(:query) do
      <<~GQL
        query {
          articles {
            id
            title
            body
          }
        }
      GQL
    end

    it "returns all articles" do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['articles']
      expect(data.size).to eq(articles.size)
      data.each_with_index do |article_data, i|
        expect(article_data).to include(
          'id' => articles[i].id.to_s,
          'title' => articles[i].title,
          'body' => articles[i].body
        )
      end
    end

    it "returns articles for a specific user" do
      user = create(:user)
      articles_for_user = create_list(:article, 2, user: user)
      query_with_variables = <<~GQL
        query($userId: ID!) {
          articles(userId: $userId) {
            id
            title
            body
          }
        }
      GQL
      post '/graphql', params: { query: query_with_variables, variables: { userId: user.id } }
      json = JSON.parse(response.body)
      data = json['data']['articles']
      expect(data.size).to eq(articles_for_user.size)
      data.each_with_index do |article_data, i|
        expect(article_data).to include(
          'id' => articles_for_user[i].id.to_s,
          'title' => articles_for_user[i].title,
          'body' => articles_for_user[i].body
        )
      end
    end
  end

  describe "comments query" do
    let!(:comments) { create_list(:comment, 3) }
    let(:query) do
      <<~GQL
        query {
          comments {
            id
            body
          }
        }
      GQL
    end

    it "returns all comments" do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['comments']
      expect(data.size).to eq(comments.size)
      data.each_with_index do |comment_data, i|
        expect(comment_data).to include(
          'id' => comments[i].id.to_s,
          'body' => comments[i].body
        )
      end
    end

    it "returns comments for a specific user" do
      user = create(:user)
      comments_for_user = create_list(:comment, 2, user: user)
      query_with_variables = <<~GQL
        query($userId: ID!) {
          comments(userId: $userId) {
            id
            body
          }
        }
      GQL
      post '/graphql', params: { query: query_with_variables, variables: { userId: user.id } }
      json = JSON.parse(response.body)
      data = json['data']['comments']
      expect(data.size).to eq(comments_for_user.size)
      data.each_with_index do |comment_data, i|
        expect(comment_data).to include(
          'id' => comments_for_user[i].id.to_s,
          'body' => comments_for_user[i].body
        )
      end
    end

    it "returns comments for a specific article" do
      article = create(:article)
      comments_for_article = create_list(:comment, 2, article: article)
      query_with_variables = <<~GQL
        query($articleId: ID!) {
          comments(articleId: $articleId) {
            id
            body
          }
        }
      GQL
      post '/graphql', params: { query: query_with_variables, variables: { articleId: article.id } }
      json = JSON.parse(response.body)
      data = json['data']['comments']
      expect(data.size).to eq(comments_for_article.size)
      data.each_with_index do |comment_data, i|
        expect(comment_data).to include(
          'id' => comments_for_article[i].id.to_s,
          'body' => comments_for_article[i].body
        )
      end
    end
  end

  describe "tags query" do
    let!(:tags) { create_list(:tag, 3) }
    let(:query) do
      <<~GQL
        query {
          tags {
            id
            name
          }
        }
      GQL
    end

    it "returns all tags" do
      post '/graphql', params: { query: query }
      json = JSON.parse(response.body)
      data = json['data']['tags']
      expect(data.size).to eq(tags.size)
      data.each_with_index do |tag_data, i|
        expect(tag_data).to include(
          'id' => tags[i].id.to_s,
          'name' => tags[i].name
        )
      end
    end

    it "returns tags with a specific name" do
      tag = create(:tag, name: "ruby")
      query_with_variables = <<~GQL
        query($name: String!) {
          tags(name: $name) {
            id
            name
          }
        }
      GQL
      post '/graphql', params: { query: query_with_variables, variables: { name: "ru" } }
      json = JSON.parse(response.body)
      data = json['data']['tags']
      expect(data.size).to eq(1)
      expect(data[0]).to include(
        'id' => tag.id.to_s,
        'name' => tag.name
      )
    end
  end
end
