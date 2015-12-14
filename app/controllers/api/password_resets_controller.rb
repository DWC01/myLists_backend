module Api
  class PasswordResetsController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json

    def create
      user = User.find_by_email(params[:email])
      if user 
        user.send_password_reset
        render json: {status: 'Email sent, check inbox for reset instructions'}, status: 200
      else
        render json: {error: 'Email not found'} , status: 422
      end
    end

    def update
      password = params[:user][:password]
      password_reset_token = params[:user][:password_reset_token]
      user = User.find_by_password_reset_token(password_reset_token)
      
      if user
        validate_and_save(user, password)
      else
        render json: {error: 'Password reset token is invalid'} , status: 422
      end
    end

    def validate_and_save(user, password)
      if user.password_reset_sent_at < 2.hours.ago
        render json: {error: 'Password reset token has expired'} , status: 422
      elsif password.blank?
        render json: {password_error: 'Password cannot be blank'} , status: 422
      elsif password.length < 6
        render json: {password_error: 'Minimum 6 characters'} , status: 422
      elsif user.update_attributes(user_params)
        render json: {user_id: user.id, status: 'Password successfully reset'}, status: 200
      else 
        render json: {errors: user.errors.to_h}, status: 422
      end
    end

    private
      def user_params
        params.require(:user).permit(
          :password, :password_confirmation
        )
      end
  end
end