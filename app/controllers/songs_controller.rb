class SongsController < ApplicationController
  def index
    #@songs = Song.all
    if params[:artist_id]
      @songs = Artist.find_by(params[:artist_id]).songs
    else
      flash[:alert] = "Artist not found."
      redirect_to artist_path
    end
  end

  def show
    @artist = Artist.find_by(params[:artist_id])
    @song = Song.find(params[:id])

    if params[:artist_id]
      @song = @artist.songs
    else
      flash[:alert] = "Artist not found."
      redirect_to artist_songs_path(@artist)
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

