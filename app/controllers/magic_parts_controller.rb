class MagicPartsController < ApplicationController
  before_action :set_magic_part, only: [:show, :edit, :update, :destroy]

  # GET /magic_parts
  # GET /magic_parts.json
  def index
    if current_user.try(:admin?)
      @magic_parts = MagicPart.all
    else
      redirect_to("/")
    end
  end

  # GET /magic_parts/1
  # GET /magic_parts/1.json
  def show
  end

  # GET /magic_parts/new
  def new
    if current_user.try(:admin?)
      @magic_part = MagicPart.new
    else
      redirect_to("/")
    end
  end

  # GET /magic_parts/1/edit
  def edit
  end

  # POST /magic_parts
  # POST /magic_parts.json
  def create
    @magic_part = MagicPart.new(magic_part_params)

    respond_to do |format|
      if @magic_part.save
        format.html { redirect_to @magic_part, notice: 'Magic part was successfully created.' }
        format.json { render :show, status: :created, location: @magic_part }
      else
        format.html { render :new }
        format.json { render json: @magic_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /magic_parts/1
  # PATCH/PUT /magic_parts/1.json
  def update
    respond_to do |format|
      if @magic_part.update(magic_part_params)
        format.html { redirect_to @magic_part, notice: 'Magic part was successfully updated.' }
        format.json { render :show, status: :ok, location: @magic_part }
      else
        format.html { render :edit }
        format.json { render json: @magic_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /magic_parts/1
  # DELETE /magic_parts/1.json
  def destroy
    @magic_part.destroy
    respond_to do |format|
      format.html { redirect_to magic_parts_url, notice: 'Magic part was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_magic_part
      @magic_part = MagicPart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def magic_part_params
      params.require(:magic_part).permit(:title, :type, :effect)
    end
end
