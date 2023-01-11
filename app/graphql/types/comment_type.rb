module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :body, String, null: false
    field :user, Types::UserType, null: true
    field :article, Types::ArticleType, null: true
  end
end
