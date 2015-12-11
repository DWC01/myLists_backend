module Api
  class BaseController < ApplicationController
    protect_from_forgery with: :null_session
    # before_action :authenticate
    respond_to :json

    protected

      def authenticate
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        authenticate_with_http_token do |auth_token, options|
          User.find_by_auth_token(auth_token)
        end
      end

      def render_unauthorized
        self.headers["WWW-Authenticate"] = 'Token realm="Application"'
        render json: {message: "Bad credentials"}, status: 401
      end
  end
end