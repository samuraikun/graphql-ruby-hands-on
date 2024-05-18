module Resolvers
  class ArticleResolver < GraphQL::Schema::Resolver
    argument :id, ID, required: true

    type Types::ArticleType, null: true

    def resolve(id:)
      Article.find(id)
    end
  end
end
