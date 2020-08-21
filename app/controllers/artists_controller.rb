class ArtistsController < ApplicationController
  before_action :authorize, only: []
  def show
    if Artist.exists?(params[:artist_id])
      @artist = Artist.find(params[:artist_id])
      render json: @artist, include: :records
    else
      render json: { error: "Could not find artist with that ID." }
    end
  end
  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      render json: @artist
    else
      render json: { error: "Unable to create artist." }
    end
  end
  def create_record
    @artist = Artist.find(params[:artist_id])
    @record = @artist.records.new(record_params)
    if @record.save
      @user.records << @record
      render json: @artist, include: :records
    else
      render status: 304, json: { error: "Could not create record."}
    end
  end

  def search
    @artists = Artist.where('lower(name) LIKE lower(?)', "%#{ params[:search_string] }%")
    render json: @artists
  end

end
