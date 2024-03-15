class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]
before_action :require_user, except: [:new, :create, :edit, :update]
before_action :require_same_user, only: [:edit, :update, :destroy]


    def show 
        @playlists = @user.playlists.paginate(page: params[:page], per_page: 3)
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 3)
    end

    def new
        @user = User.new
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Your account information was succesfully updated!"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
        @device = @user.devices.create(name: params[:user][:name], unique_identifier: params[:user][:unique_identifier])
            session[:user_id] = @user.id
            flash[:notice] = "Welcome #{@user.username}, you have succesfully signed up!"
             redirect_to playlists_path
        else
            render 'new'
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account and all the associated playlists are succesfully deleted!"
        redirect_to @user
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :device_name)
    end

    def set_user        
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You cannot edit or delete others profiles!"
            redirect_to @user
        end
    end


end