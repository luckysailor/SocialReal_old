require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @profile = Profile.new(user_id: 2)
    @profile.name = 'Someone'
    @profile.email = "someone@social-real.tk"
    @profile.location = "California"
    @profile.language = "English"
    @profile.favorite_topics = "Sports"
    @profile.my_articles = "social-real.tk/my_article"
    @profile.my_softwares_client = "mIRC and XChat"
  end

  test "should not save profile without name" do
    @profile.name = nil
    assert !@profile.save, "Saved profile with param name blank"
  end

  test "should not save profile if name is small" do
    @profile.name = 'Hi'
    assert !@profile.save, "Saved profile with param name small than 5"
  end

  test "should not save profile if name is large" do
    @profile.name = 'Lorem Ipsum Dolor Sit Posuere Aenean'
    assert !@profile.save, "Saved profile with param name large than 22"
  end

  test "should not save profile if location is large" do
		@profile.location = 'Lorem ipsum dolor sit amet consectetur adipiscing elit'
		assert !@profile.save, "Saved profile with param location large than 16"
	end

  test "should not save profile if language is large" do
    @profile.language = 'Lorem Ipsum Dolor Sit Posuere Aenean'
    assert !@profile.save, "Saved profile with param language large than 16"
  end

  test "should not save profile if favorite_topics is large" do
		@profile.favorite_topics = 'Lorem ipsum dolor sit amet consectetur adipiscing elit'
		assert !@profile.save, "Saved profile with param favorite_topics large than 30"
	end

  test "should not save profile if my_articles is large" do
		@profile.my_articles = 'Lorem ipsum dolor sit amet consectetur adipiscing elit'
		assert !@profile.save, "Saved profile with param my_articles large than 30"
	end

  test "should not save profile if my_softwares_client is large" do
		@profile.my_softwares_client = 'Lorem ipsum dolor sit amet consectetur adipiscing elit'
		assert !@profile.save, "Saved profile with param my_softwares_client large than 30"
	end

	test "should not save profile if email is invalid" do
		@profile.email = 'someone#social-real.tk'
		assert !@profile.save, "Saved profile with email correct"
	end
end
