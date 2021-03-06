class SongsController < ApplicationController
	before_action :set_song, only: [:show, :edit, :update]

	def index
		@songs = Song.all
	end

	def show
		@artist = @song.artist
		@genre = @song.genre
	end

	def new
		@song = Song.new
	end

	def create
		@song = Song.new(song_params)
		if @song.save
			redirect_to song_path(@song)
		end
	end

	def edit

	end

	def update
		if @song.update(song_params)
			redirect_to song_path(@song)
		end
	end

	private
		def set_song
			@song = Song.find(params[:id])
		end

		def song_params
			params.require(:song).permit(:name, :artist_id, :genre_id)
		end
end