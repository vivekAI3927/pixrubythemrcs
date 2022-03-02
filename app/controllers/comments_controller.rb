class CommentsController < ApplicationController
  # before_action :authenticate_user!

  def create
    @comment = @commentable.comments.new comment_params
    @comment.admin = current_admin
    @comment.save
    if params[:user_id].present?
      redirect_to "/admin/users/#{params[:user_id]}"
    elsif params[:admin_id].present?
      redirect_to "/admin/admins/#{params[:admin_id]}"
    end 
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
