class BoatsController < ApplicationController
  before_action :set_boat, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def search
    if params[:search].present?
      @boats = Boat.search(params[:search])
    else
      @boats = Boat.all
    end
  end

  def index
    @boats = Boat.all
  end

  def show
    @reviews = Review.where(boat_id: @boat.id).order("created_at DESC")

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  def new
    @boat = current_user.boats.build
  end

  def edit
  end

  def create
    @boat = current_user.boats.build(boat_params)

    respond_to do |format|
      if @boat.save
        format.html { redirect_to @boat, notice: 'Boat was successfully created.' }
        format.json { render :show, status: :created, location: @boat }
      else
        format.html { render :new }
        format.json { render json: @boat.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @boat.update(boat_params)
        format.html { redirect_to @boat, notice: 'Boat was successfully updated.' }
        format.json { render :show, status: :ok, location: @boat }
      else
        format.html { render :edit }
        format.json { render json: @boat.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @boat.destroy
    respond_to do |format|
      format.html { redirect_to boats_url, notice: 'Boat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_boat
      @boat = Boat.find(params[:id])
    end

    def boat_params
      params.require(:boat).permit(:title, :description, :boat_length, :director, :rating, :image)
    end
end
