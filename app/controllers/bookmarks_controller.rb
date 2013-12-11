class BookmarksController < ApplicationController

  respond_to :json
  before_filter :fail_unless_logged_in

  def create
    Bookmark.create!(
      params.require(:bookmark).permit(:url)
        .merge creator: current_user
    )
  end

  def show
  end

  def update
  end

  def destroy
  end

end
