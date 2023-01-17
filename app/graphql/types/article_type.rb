module Types
  class ArticleType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :user, Types::UserType, null: false
    field :comments, [Types::CommentType], null: true, preload: { comments: :user }
    field :tags, [Types::TagType], null: true, preload: { taggings: :tag }

    def user
      BatchLoader::GraphQL.for(object.user_id).batch do |user_ids, loader|
        User.where(id: user_ids).each { |user| loader.call(user.id, user) }
      end
    end

    def comments
      BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |article_ids, loader|
        Comment.where(article_id: article_ids).each do |comment|
          loader.call(comment.article_id) { |memo| memo << comment }
        end
      end
    end
  end
end
