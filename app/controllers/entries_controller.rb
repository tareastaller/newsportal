class EntriesController < ApplicationController
  before_action :find_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entries = Entry.all.order("created_at DESC")
    @entries = @entries[0..9]
  end

  def new
    if user_signed_in?
      @entry = Entry.new
    else
      redirect_to root_path
    end
  end

  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      redirect_to root_path
    else
      render 'new'
    end

  end

  def show
    @entry = Entry.find(params[:id])
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      redirect_to entry_path(@entry)
    else
      render 'edit'
    end
  end

  def list
    if user_signed_in?
      @entries = Entry.all.order("created_at DESC")
    else
      redirect_to root_path
    end
  end

  def destroy
    @entry.destroy
    redirect_to list_path
  end

  private

    def entry_params
      params.require(:entry).permit(:titular, :bajada, :cuerpo)
    end

    def find_entry
      @entry = Entry.find(params[:id])
    end

    def current_u
       @current_u ||= User.find(session[:user_id]) if session[:user_id]
    end
end
