class ProjectsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  load_and_authorize_resource

  def index
    render json: @projects
  end

  def create
    if @project.save
      render json: @project
    else
      render json: { message: I18n.t('project.error_save') }, status: 200
    end
  end

  def update
    if @project.update(project_params)
      render json: { nothing: true }
    else
      render json: { message: I18n.t('project.error_update') }, status: 200
    end
  end

  def destroy
    @project.destroy
    render json: { nothing: true }
  end

  private

    def project_params
      params.permit(:name)
    end

end
