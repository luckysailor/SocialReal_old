class ProfilesController < ApplicationController
  include Authenticate
  layout 'dashboard'
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  def show
    # FIX-ME with gem Draper-Decorator
    @current_profile_is_from_current_user = current_user_can_edit?
  end

  # GET /profiles/new
  def new
    if current_user_have_profile?
      redirect_to current_user.profile
    else
      @profile = Profile.new
    end
  end

  # GET /profiles/1/edit
  def edit
    render action: 'show' unless current_user_can_edit?
  end

  # POST /profiles
  def create
    if current_user.profile.present?
      redirect_to current_user.profile 
    else
      @profile = Profile.new(profile_params)
      @profile.user = current_user

      respond_to do |format|
        if @profile.save
          format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
          else
          format.html { render action: 'new' }
          end
      end
    end
  end

  # PATCH/PUT /profiles/1
  def update
    if current_user_can_edit?
      respond_to do |format|
        if @profile.update(profile_params)
          format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        else
          format.html { render action: 'edit' }
        end
      end
    else
      redirect_to new_profile_path
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = current_user_profile
  end

  def current_user_can_edit?
    set_profile.user == current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:name, :email, :picture, :location, :language, :favorite_topics, :my_articles, :my_softwares_client, :hidden)
  end
end
