class GenresController < ApplicationController

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find_by(id: params[:id])
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.create(post_params)
    redirect_to genre_path @genre
  end

  def edit
    @genre = Genre.find_by(params[:id])
  end

  def update
    @genre = Genre.find_by(id: params[:id])
    @genre.update(post_params)
    redirect_to genre_path @genre
  end

  private
    def post_params
      params.require(:genre).permit(:name)
    end
end
