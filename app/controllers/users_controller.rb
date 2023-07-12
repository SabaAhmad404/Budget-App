class Users < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
        @users=User.all
    end
    
    def show
    end

    def edit
    end

    def new
        @user=User.new
    end

    def create
        @user=User.new(user_params)
        if@user.save
            redirect_to user_url(@user), notice: 'User was created Successfully'
        else
            render :new
        end
    end

    def update
        @user=User.new(user_params)
        if @user.save
            redirect_to user_url(@user), notice: 'User was updated Succesfully'
        else
            render :edit
        end
    end

    def destroy 
        @user.destroy
        redirect_to users_url, notice: 'User is destroy successfully'
    end

    private
    def set_user
        @user=User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name)
    end
end