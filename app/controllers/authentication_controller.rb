class AuthenticationController < ApplicationController
    before_action :authenticate_request, except: :login

    def login
        @user = User.find_by(email_address: params[:email_address])
        if @user&.authenticate(params[:password])
            token = jwt_encode(user_id: @user.id)
            render json: { token: token }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

    private

    def login_params
        params.permit(:email_address, :password)
    end

end