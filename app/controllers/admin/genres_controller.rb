class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!  # genresコントローラのすべての機能は管理者としてログインしていないと使えない

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
  end

  def create
    @genre = Genre.new(genre_params)
    @genres = Genre.all
    if @genre.save()
      @genre = Genre.new
    end

    render :index
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
