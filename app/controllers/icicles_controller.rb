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
    phone = @icicle.phone.to_s
    @start_time = Time.now
    mapping = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q", "r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}
    @dictionary = []
    File.foreach( @path ) do |word|
      @dictionary.push word.chop.to_s.downcase
    end
    @keys = phone.chars.map{|digit|mapping[digit]}
    @result3 = []
    @result7 = []
    @keys3 = phone[0..2].chars.map{|digit|mapping[digit]}
    @result3 << @keys3.shift.product(*@keys3).map(&:join)
    @keys7 = phone[3..9].chars.map{|digit|mapping[digit]}
    @result7 << @keys7.shift.product(*@keys7).map(&:join)
    @desired_result_3 = @dictionary & @result3.flatten
    @desired_result_7 = @dictionary & @result7.flatten
    @best_result = @desired_result_3.product(@desired_result_7)

    @result4 = []
    @result6 = []
    @keys4 = phone[0..3].chars.map{|digit|mapping[digit]}
    @result4 << @keys4.shift.product(*@keys4).map(&:join)
    @keys6 = phone[4..9].chars.map{|digit|mapping[digit]}
    @result6 << @keys6.shift.product(*@keys6).map(&:join)
    @desired_result_4 = @dictionary & @result4.flatten
    @desired_result_6 = @dictionary & @result6.flatten
    @best_result_1 = @desired_result_4.product(@desired_result_6)

    @result5 = []
    @result_5 = []
    @keys5 = phone[0..4].chars.map{|digit|mapping[digit]}
    @result5 << @keys5.shift.product(*@keys5).map(&:join)
    @keys_5 = phone[5..9].chars.map{|digit|mapping[digit]}
    @result_5 << @keys_5.shift.product(*@keys_5).map(&:join)
    @desired_result5 = @dictionary & @result5.flatten
    @desired_result_5 = @dictionary & @result_5.flatten
    @best_result_2 = @desired_result5.product(@desired_result_5)

    @result10 = []
    @keys10 = phone.chars.map{|digit|mapping[digit]}
    @result10 << @keys.shift.product(*@keys).map(&:join)
    @best_result_3 = @dictionary & @result10.flatten
    
    @desired_result_10 = @best_result + @best_result_1 + @best_result_2
    @desired_result_new = @desired_result_10.sort + @best_result_3
    @end_time = Time.now
    @time_taken = (@end_time - @start_time)*1000.0
  end


=begin
    @available_letters = []
    @available_letters << @keys
    a = @available_letters.flatten
    @combination_3 = a.combination(3).map(&:join)
    @combination_7 = a.combination(7).map(&:join)

    @result = []
    @result << @keys.shift.product(*@keys).map(&:join)
    @desired_result_3 = @dictionary & @combination_3
    @desired_result_7 = @dictionary & @combination_7
    @desired_result = @desired_result_3.product(@desired_result_7) 
=end


=begin
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
=end

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
