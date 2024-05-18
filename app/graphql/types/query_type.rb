module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :user, resolver: Resolvers::UserResolver
    field :users, resolver: Resolvers::UsersResolver
    field :article, resolver:  Resolvers::ArticleResolver
    field :articles, resolver:  Resolvers::ArticlesResolver
    field :comments, resolver:  Resolvers::CommentsResolver
    field :tags, resolver:  Resolvers::TagsResolver
  end
end
