class BookmarksController < ApplicationController

  respond_to :json
  before_filter :fail_unless_logged_in
  before_filter :load_bookmark, only: [:show, :destroy]

  def create
    respond_with Bookmark.create!(
      params.require(:bookmark).permit(:url)
        .merge creator: current_user
    )
  end

  def show
    respond_with @bmk
  end

  def destroy
    @bmk.delete
    head :ok
  end

  def index
    if not params[:user_id].nil?
      respond_with Bookmark.where creator_id: params[:user_id]
    else
      head :not_found
    end
  end

  def load_bookmark
    if params[:id].nil? or (@bmk = Bookmark.find params[:id]).nil?
      head :not_found
    end
  end

end
