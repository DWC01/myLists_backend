module Api
  class UsersController < Api::BaseController

    def index
      users = User.where(query_params)
      if users
        render json: users, status: 200
      else
        render json: {message: 'No users found'}, status: 422
      end
    end

    def show
      user = User.find(params[:id])
      if user
        render json: user, status: 200
      else
        render json: {message: 'User Not Found'}, status: 422
      end
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: 201
      else
        render json: {errors: user.errors.to_h}, status: 422
      end
    end

    def update
      user = User.find(params[:id])
      if user.update_attributes(sanitized_user_params)
        render json: user, status: 200
      else
        render json: {errors: user.errors.to_h}, status: 422
      end
    end

    def destroy
      user = User.find(params[:id])
      user.destroy
      head :no_content
    end

    private
      def user_params
        params.require(:user).permit(
          :id, :first_name, :last_name, :email, :admin,
          :password, :password_confirmation
        )
      end

      def sanitized_user_params
        user_params.compact
      end

      def query_params
        params.permit(:auth_token)
      end
  end
end