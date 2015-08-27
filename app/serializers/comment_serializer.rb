class CommentSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :comment_attachments
end
