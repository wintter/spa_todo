class AddCommentRefToCOmmentAttachment < ActiveRecord::Migration
  def change
    add_reference :comment_attachments, :comment, index: true
  end
end
