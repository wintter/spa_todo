class TaskListSerializer < ActiveModel::Serializer
  attributes :id, :deadline, :status, :name, :position
  has_many :comments
end
