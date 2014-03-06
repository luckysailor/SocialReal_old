require 'test_helper'
require 'carrierwave/test/matchers'

class ProfileTest < ActiveSupport::TestCase
  include CarrierWave::Test::Matchers

  if Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
      config.enable_processing = false
    end
  end

  setup do
    @profile = profiles(:one)
    PictureUploader.enable_processing = true
    @uploader = PictureUploader.new(@profile)
    @file_name = 'test_image.png'
    @uploader.store!(File.open("public/#{@file_name}"))
  end

  def teardown
    PictureUploader.enable_processing = false
    @uploader.remove!
  end

  test "picture shoud have dimensions 150x150" do
    dimensions_expected = have_dimensions(150, 150)
    assert dimensions_expected.matches?(@uploader), dimensions_expected.negative_failure_message
  end

  test "picture shoud have thumb version 50x50" do
    dimensions_expected = have_dimensions(50, 50)
    assert dimensions_expected.matches?(@uploader.thumb), dimensions_expected.negative_failure_message
  end

  test "picture shoud have name encoded in md5" do
    picture_name_md5 = Digest::MD5.hexdigest(@file_name)
    picture_name = @uploader.filename.match(/(.*)\./).captures[0]
    assert_equal picture_name_md5, picture_name
  end
end