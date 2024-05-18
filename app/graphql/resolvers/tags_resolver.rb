module Resolvers
  class TagsResolver < GraphQL::Schema::Resolver
    argument :name, String, required: false

    type [Types::TagType], null: false

    def resolve(name: nil)
      if name
        Tag.where("name like ?", "#{name}%")
      else
        Tag.all
      end
    end
  end
end
