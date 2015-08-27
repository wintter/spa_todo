class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :task_lists
  belongs_to :user
end
