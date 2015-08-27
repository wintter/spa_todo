class CreateCommentAttachments < ActiveRecord::Migration
  def change
    create_table :comment_attachments do |t|
      t.string :data

      t.timestamps null: false
    end
  end
end
