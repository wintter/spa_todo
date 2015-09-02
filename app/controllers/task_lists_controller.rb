class TaskListsController < ApplicationController
  load_and_authorize_resource

  def index
    render json: @task_lists
  end

  def create
    if @task_list.save
      render json: @task_list
    else
      render json: { message: I18n.t('task_list.error_save') }, status: 200
    end
  end

	def update
    if @task_list.update(task_list_params)
      render json: { nothing: true }
    else
      render json: { message: I18n.t('task_list.error_update') }, status: 200
    end
  end

  def destroy
    @task_list.destroy
    render json: @task_list
  end

  private

    def task_list_params
      params.permit(:status, :name, :deadline, :position, :project_id)
    end

end
