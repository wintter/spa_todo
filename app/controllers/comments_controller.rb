class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    if @comment.save
      render json: @comment
    else
      render json: { message: I18n.t('comment.error_save') }, status: 200
    end
  end

  def update
    if @comment.update(comment_params)
      render json: { nothing: true }
    else
      render json: { message: I18n.t('comment.error_update') }, status: 200
    end
  end

  def destroy
    @comment.destroy
    render json: { nothing: true }
  end

  def attach_files
    auth = {
        cloud_name: "dj4ahcvxs",
        api_key:    "171719699671231",
        api_secret: "awAsajcJU0MHK85BtSEqR9TW7es"
    }

    Cloudinary::Uploader.upload(params[:file], auth)
    #@comment.comment_attachments.create!(data: params[:file])
    render json: { nothing: true }
  end

  private

    def comment_params
      params.permit(:name, :task_list_id)
    end

end
