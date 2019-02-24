class Icicle < ApplicationRecord
	has_one_attached :upload
	validates_length_of :phone, is: 10,  message: "Phone Number must be 10 digit long"
	validates :phone, numericality: { other_than: 0 } 
	validate :file_presence

	def upload_path
		ActiveStorage::Blob.service.path_for(upload.key)
	end

	def self.my_map(path,phone)
		puts path
		puts phone
		mapping = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q", "r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}
		@dictionary = []
		File.foreach( path ) do |word|
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
		return @desired_result_new
	end

	private
	def file_presence
		if upload.attached? == false
			errors.add(:upload, "is missing.")
		end
	end
end
