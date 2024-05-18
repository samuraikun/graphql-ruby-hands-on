module Resolvers
  class UsersResolver < GraphQL::Schema::Resolver
    description "Fetch All Users"

    type [Types::UserType], null: false

    def resolve
      User.all
    end
  end
end
