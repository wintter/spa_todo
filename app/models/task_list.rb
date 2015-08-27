class TaskList < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :project
  has_many :comments

  def task_user
    project.user
  end

end
