module Resolvers
  class ArticlesResolver < GraphQL::Schema::Resolver
    argument :user_id, ID, required: false

    type [Types::ArticleType], null: true

    def resolve(user_id: nil)
      if user_id
        Article.where(user_id: user_id)
      else
        Article.all
      end
    end
  end
end
