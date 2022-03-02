class Admins::CommentsController < CommentsController
  before_action :set_commentable

  private

    def set_commentable
      @commentable = Admin.find(params[:admin_id])
    end
end
