module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :user, Types::UserType, null: true do
      description "Find User by ID"
      argument :id, ID, required: true
    end
    def user(id:)
      User.find(id)
    end

    field :users, [Types::UserType], null: false do
      description "Fetch All Users"
    end
    def users(page: nil, items: nil)
      User.all
    end

    field :article, Types::ArticleType, null: true do
      argument :id, ID, required: true
    end
    def article(id:)
      Article.find(id)
    end

    field :articles, [Types::ArticleType], null: true do
      argument :user_id, ID, required: false
    end
    def articles(user_id: nil)
      if user_id
        Article.where(user_id: user_id)
      else
        Article.all
      end
    end

    field :comments, [Types::CommentType], null: false do
      argument :id, ID, required: false
      argument :user_id, ID, required: false
      argument :article_id, ID, required: false
    end
    def comments(id: nil, user_id: nil, article_id: nil)
      scope = Comment.all
      scope = scope.where(id: id) if id
      scope = scope.where(user_id: user_id) if user_id
      scope = scope.where(article_id: article_id) if article_id
      scope
    end

    field :tags, [Types::TagType], null: false do
      argument :name, String, required: false
    end
    def tags(name: nil)
      if name
        Tag.where("name like ?", "#{name}%")
      else
        Tag.all
      end
    end
  end
end
