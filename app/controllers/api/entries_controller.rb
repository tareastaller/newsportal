module Api
  class EntriesController < ApplicationController
    protect_from_forgery with: :null_session
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

    def index
      @entries = Entry.all.order("created_at DESC");
      #render json: {status: 'SUCCESS', message: 'Loaded entries', data:entries},status: :ok
      render 'entries/index.json.jbuilder'
    end

    def show
      #entry = Entry.find(params[:entry_id])
      #render json: {status: 'SUCCESS', message: 'Loaded entry', data:entry},status: :ok
      @entry = Entry.find(params[:id])
      if @entry
        render 'entries/show.json.jbuilder'
      #else
      #  render :json => "404"
        #render json: {post: "not found"}, status: :not_found
      end
    end

    def create
      @entry = Entry.new
      @entry.titular = params[:title]
      @entry.bajada = params[:subtitle]
      @entry.cuerpo = params[:body]

      if @entry.save
        #render json: {status: 'SUCCESS', message: 'Saved entry', data:entry},status: :ok
        render 'entries/create.json.jbuilder', status: 201
      else
        render json: {status: 'ERROR', message: 'Entry not saved', data:entry.errors},status: :unprocessable_entity
      end

    end

    def destroy
      @entry = Entry.find(params[:id])
      if @entry
        @entry.destroy
        render json: {status: 'SUCCESS', message: 'Deleted entry', data:@entry},status: :ok
      end
    end

    def update
      @entry = Entry.find(params[:id])
      if @entry.update_attributes({:titular => entry_params[:title], :bajada => entry_params[:subtitle], :cuerpo => entry_params[:body]}.reject{|k,v| v.blank?})
        #render json: {status: 'SUCCESS', message: 'Updated entry', data:@entry},status: :ok
        render 'entries/update.json.jbuilder'
      else
        render json: {status: 'ERROR', message: 'Entry not updated', data:@entry.errors},status: :unprocessable_entity
      end

    end

    private

    def entry_params
      params.permit(:title, :subtitle, :body)
    end


    def record_not_found(error)
      render json: { error: 'Not Found' }, status: :not_found
    end

  end
end
