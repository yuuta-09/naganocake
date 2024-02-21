class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!  # genresコントローラのすべての機能は管理者としてログインしていないと使えない

  def index
    @genre = Genre.new  # 新規投稿用の変数
    @genres = Genre.all # 一覧表示用の変数
  end

  def edit
    @genre = Genre.find(params[:id]) # 編集フォーム用の変数
  end

  def create
    @genre = Genre.new(genre_params)   # 保存するモデルの変数
    if @genre.save
      @genres = Genre.all              # renderの際に使用する一覧表示用の変数
      
      redirect_to admin_genres_path    # urlがずれるため基本的にはredirect
    else
      render :index                    # 保存に失敗したときは既存データを使いたいためrender
    end
  end

  def update
    @genre = Genre.find(params[:id])  # urlに含まれる:idをもとにGenreを取得
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    # フォームから送られてくるときに許可するgenreのデータを指定
    params.require(:genre).permit(:name)
  end
end
