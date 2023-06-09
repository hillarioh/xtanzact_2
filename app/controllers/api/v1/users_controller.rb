class Api::V1::UsersController < ApplicationController
    before_action :authenticate_request, except: :create
    before_action :find_user, only: [:update, :destroy]


    def index 
        @users = User.where.not(id: @current_user.id)
        render json: @users, status: :ok
    end

    def create
        @user = User.new(user_params)
        if @user.save
            Account.create(user: @user)
            Account.create(user: @user, account_type: 1)
            render json: @user, status: :created
        else
            render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params)
            render json: @user, status: :ok
        else
            render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
    end    

    private

    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :tel_no, :email_address, :password, :password_confirmation)
    end

end