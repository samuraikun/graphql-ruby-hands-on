class Types::TagType < Types::BaseObject
  field :id, ID, null: false
  field :name, String, null: false
  field :articles, [Types::ArticleType], null: true
end
