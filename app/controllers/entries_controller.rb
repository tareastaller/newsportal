class EntriesController < ApplicationController
  before_action :find_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entries = Entry.all.order("created_at DESC")
  end

  def new
    @entry = Entry.new
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

  def destroy
  end

  private

    def entry_params
      params.require(:entry).permit(:titular, :bajada, :cuerpo)
    end

    def find_entry
      @entry = Entry.find(params[:id])
    end
end
