class Comment < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :task_list
  has_many :comment_attachments, dependent: :destroy

  def comment_user
    task_list.project.user
  end

end
