class Icicle < ApplicationRecord
	#include NumberToWord
	has_one_attached :upload
	validates_length_of :phone, is: 10,  message: "Phone Number must be 10 digit long"
	validates :phone, numericality: { other_than: 0 } 
	validate :file_presence

	def upload_path
		ActiveStorage::Blob.service.path_for(upload.key)
	end

	private
	def file_presence
		if upload.attached? == false
			errors.add(:upload, "is missing.")
		end
	end
end
