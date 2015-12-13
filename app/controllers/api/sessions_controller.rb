module Api
  class SessionsController < Api::BaseController
    attr_reader :password_err, :email_err

    def initialize 
      @password_err = "Invalid password"
      @email_err    = "Email could not be found"
    end

    def create
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        render json: user, serializer: UserSerializer, status: 200
      elsif user
        render json: {errors: {password: password_err}}, status: 422
      else
        render json: {errors: {email: email_err}}, status: 422
      end
    end

    private
      def session_params
        params.permit(:email, :password)
      end
  end
end