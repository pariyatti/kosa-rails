class UsersController < Clearance::UsersController
  layout 'settings'
  before_action :set_user, only: [:show]
  before_action :require_login

  # This is required to override the Clearance default, which assumes
  # that we want a "sign up" workflow. We don't. Existing admin users
  # create more admin users instead.
  skip_before_action :redirect_signed_in_users, only: [:create, :new]

  def index
    @users = User.all
  end

  def new
    @user = user_from_params
  end

  def show
  end

  def create
    @user = User.new(user_create_params)    
    @user.email = user_create_params.delete(:email)
    @user.password = user_create_params.delete(:password)
    @user.admin = true
    @user.reset_remember_token!

    if @user.save
      #sign_in @user
      redirect_to user_url(@user), notice: 'User was successfully created.'
    else
      flash[:error] = 'Failed to save user.'
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_create_params
    params.require(:user).permit(:email, :password)
  end

end
