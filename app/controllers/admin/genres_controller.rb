class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!  # genresコントローラのすべての機能は管理者としてログインしていないと使えない

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
  end
end
