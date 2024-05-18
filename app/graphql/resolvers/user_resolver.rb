module Resolvers
  class UserResolver < GraphQL::Schema::Resolver
    description "Find User by ID"

    argument :id, ID, required: true

    type Types::UserType, null: true

    def resolve(id:)
      User.find(id)
    end
  end
end
