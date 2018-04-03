module Api
  class CommentsController < ApplicationController
    protect_from_forgery with: :null_session
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

    def index
      entry = Entry.find(params[:entry_id])
      @comments = entry.comments
      render 'comments/index.json.jbuilder'
      #render json: {status: 'SUCCESS', message: 'Loaded Comments', data:comments},status: :ok
    end

    def show
      entry = Entry.find(params[:entry_id])
      @comment = entry.comments.find(params[:id])
      #render json: {status: 'SUCCESS', message: 'Loaded Comment', data:@comment},status: :ok
      render 'comments/show.json.jbuilder'
    end

    def create
      @comment = Comment.new
      @comment.nombre = comment_params[:author]
      @comment.contenido = comment_params[:comment]
      @comment.entry_id = params[:entry_id]

      if @comment.save
        #render json: {status: 'SUCCESS', message: 'Saved comment', data:comment},status: :ok
        render 'comments/create.json.jbuilder', status: 201
      else
        render json: {status: 'ERROR', message: 'Comment not saved', data:@comment.errors},status: :unprocessable_entity
      end

    end

    def destroy
      entry = Entry.find(params[:entry_id])
      comment = entry.comments.find(params[:id])
      comment.destroy
      render json: {status: 'SUCCESS', message: 'Deleted comment', data:comment},status: :ok
    end

    def update
      entry = Entry.find(params[:entry_id])
      @comment = entry.comments.find(params[:id])
      if @comment.update_attributes({:nombre => entry_params[:author], :contenido => entry_params[:comment]}.reject{|k,v| v.blank?})
        #render json: {status: 'SUCCESS', message: 'Updated comment', data:comment},status: :ok
        render 'comments/update.json.jbuilder'
      else
        render json: {status: 'ERROR', message: 'Comment not updated', data:@comment.errors},status: :unprocessable_entity
      end

    end


    private

      def comment_params
        params.permit(:author, :comment)
      end

      def record_not_found(error)
        render json: { error: 'Not Found' }, status: :not_found
      end

  end
end
