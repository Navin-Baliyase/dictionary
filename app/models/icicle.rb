class Icicle < ApplicationRecord
	has_one_attached :upload
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
