# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # This action provides incremental search for registered users by ajax scheme.
  def index
    @users = User.where('name LIKE(?)',"%#{params[:keyword]}%").where("id != #{current_user.id}")
    binding.pry
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  # end

  # GET /resource/edit
  # def edit
  # end

  # PUT /resource
  def update
    @user = User.find(current_user)
    if @user.update(update_create_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  # permit the keyword to search users
  def configure_rendering_params
    params.permit(:controller, :action)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def update_create_params
    params.require(:user).permit(:name, :email)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
