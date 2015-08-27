class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :task_lists
end
