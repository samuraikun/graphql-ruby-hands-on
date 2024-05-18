module Resolvers
  class CommentsResolver < GraphQL::Schema::Resolver
    argument :id, ID, required: false
    argument :user_id, ID, required: false
    argument :article_id, ID, required: false

    type [Types::CommentType], null: false

    def resolve(id: nil, user_id: nil, article_id: nil)
      scope = Comment.all
      scope = scope.where(id: id) if id
      scope = scope.where(user_id: user_id) if user_id
      scope = scope.where(article_id: article_id) if article_id
      scope
    end
  end
end
