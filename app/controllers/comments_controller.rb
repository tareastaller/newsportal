class CommentsController < ApplicationController
  before_action :find_entry

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.entry_id = @entry.id

    if @comment.save
      redirect_to entry_path(@entry)
    else
      render 'new'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:nombre, :contenido)
    end

    def find_entry
      @entry = Entry.find(params[:entry_id])
    end

end
