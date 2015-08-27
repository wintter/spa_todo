class CommentAttachment < ActiveRecord::Base
  mount_uploader :data, DataUploader
  belongs_to :comment
end
