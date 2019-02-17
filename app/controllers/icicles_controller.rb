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
    @data = File.read(@icicle.upload_path)
    @path = @icicle.upload_path
    digits = @icicle.phone.to_s
    letters = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q", "r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}
    dictionary = []
    file_path = @path
    File.foreach( file_path ) do |word|
      dictionary.push word.chop.to_s.downcase
    end
    keys = digits.chars.map{|digit|letters[digit]}

    results = {}
    total_number = keys.length - 1
    for i in (2..total_number)
      first_array = keys[0..i]
      second_array = keys[i + 1..total_number]
      next if first_array.length < 3 || second_array.length < 3
      first_combination = first_array.shift.product(*first_array).map(&:join)
      next if first_combination.nil?
      second_combination = second_array.shift.product(*second_array).map(&:join)
      next if second_combination.nil?
      results[i] = [(first_combination & dictionary), (second_combination & dictionary)]
    end
    @final_words = []
    results.each do |key, combinataions|
      next if combinataions.first.nil? || combinataions.last.nil?
      combinataions.first.product(combinataions.last).each do |combo_words|
        @final_words << combo_words
      end
    end
    @final_words << (keys.shift.product(*keys).map(&:join) & dictionary).join(", ")
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
