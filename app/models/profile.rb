class Profile < ActiveRecord::Base
	belongs_to :user
  
	mount_uploader :picture, PictureUploader
  
  validates :name, length: { minimum: 5, maximum: 22 }, presence: true
	validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, 
		maximum: 30 }, if: Proc.new { |profile| profile.email.present? }
	validates :location, :language, length: { maximum: 16 }
	validates :favorite_topics, :my_articles, :my_softwares_client, length: { maximum: 30 }
	validates :hidden, inclusion: { in: [true, false] } 
	validate :picture_size_validation, :if => "picture?"

	private

  def picture_size_validation
    errors[:picture] << "should be less than 1MB" if picture.size > 1.megabytes
  end
end