class CommentAttachmentSerializer < ActiveModel::Serializer
  attributes :id, :data_identifier, :data_url
end
