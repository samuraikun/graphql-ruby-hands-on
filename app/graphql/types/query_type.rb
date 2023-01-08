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
    def users(page: nil, items: nil)
      User.all
    end
  end
end
