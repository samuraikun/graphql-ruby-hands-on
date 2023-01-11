module Types
  class ArticleType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :user, Types::UserType, null: false
    field :comments, [Types::CommentType], null: true
    field :tags, [Types::TagType], null: true
  end
end
