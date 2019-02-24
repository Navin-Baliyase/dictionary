class IciclesController < ApplicationController
  #require 'number_to_word'
  before_action :set_icicle, only: [:show, :edit, :update, :destroy]

  # GET /icicles
  # GET /icicles.json
  def index
    @icicles = Icicle.all
  end

  # GET /icicles/1
  # GET /icicles/1.json
  def show
    @path = @icicle.upload_path
    @phone = @icicle.phone.to_s
    @start_time = Time.now
    @desired_result_new = Icicle.my_map(@path,@phone)
    @end_time = Time.now
    @time_taken = (@end_time - @start_time)*1000.0
  end

  # GET /icicles/new
  def new
    @icicle = Icicle.new
  end

  # GET /icicles/1/edit
  def edit
  end

  # POST /icicles
  # POST /icicles.json
  def create
    @icicle = Icicle.new(icicle_params)

    respond_to do |format|
      if @icicle.save
        format.html { redirect_to @icicle, notice: 'Icicle was successfully created.' }
        format.json { render :show, status: :created, location: @icicle }
      else
        format.html { render :new }
        format.json { render json: @icicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /icicles/1
  # PATCH/PUT /icicles/1.json
  def update
    respond_to do |format|
      if @icicle.update(icicle_params)
        format.html { redirect_to @icicle, notice: 'Icicle was successfully updated.' }
        format.json { render :show, status: :ok, location: @icicle }
      else
        format.html { render :edit }
        format.json { render json: @icicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /icicles/1
  # DELETE /icicles/1.json
  def destroy
    @icicle.destroy
    respond_to do |format|
      format.html { redirect_to icicles_url, notice: 'Icicle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_icicle
      @icicle = Icicle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def icicle_params
      params.require(:icicle).permit(:phone, :upload)
    end
  end
