class Console::ProfilesController < Console::ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  after_action only: [:create, :update] do 
    update_posttext(@profile, posttext_params)
    update_avatar(@profile, avatar_params)
  end

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = current_user.build_profile
  end

  # GET /profiles/1/edit
  def edit
    @profile ||= current_user.build_profile
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = current_user.build_profile(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to console_profile_path(@profile), notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: console_profile_path(@profile) }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to console_profile_path(@profile), notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: console_profile_path(@profile) }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to console_profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      # @profile = Profile.find(params[:id])
      @profile = current_user.profile
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:user_id, :location, :company, :tagline)
    end

    def posttext_params
      params.require(:posttext).permit(:body)
    end

    def avatar_params
      params.require(:avatar).permit(:url)
    end
end