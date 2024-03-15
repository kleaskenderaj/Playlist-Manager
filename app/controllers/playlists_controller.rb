class PlaylistsController < ApplicationController

    before_action :set_playlist, only: [:show, :edit, :update, :destroy]
    before_action :require_user, expect: [:show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show 
        @playlist = Playlist.includes(:medium).find(params[:id])
    end

    def index
         @playlists = Playlist.paginate(page: params[:page], per_page: 3)
         @playlists = Playlist.filter_by_title(params[:search]).paginate(page: params[:page], per_page: 3)
  
    end


    def new
        @playlist = Playlist.new
    end

    def edit 

    end

    def create
        @playlist = Playlist.new(playlist_params)
        @playlist.user = current_user
        if @playlist.save
            flash[:notice] = "Playlist was created successfully!"
            redirect_to @playlist
        else
            render 'new'
        end

    end

    def update 
        if @playlist.update(playlist_params)
            flash[:notice] = "Article was updated succesfully!"
            redirect_to @playlist
        else
            render 'edit'
        end
    end

    def destroy
        @playlist.destroy
        redirect_to playlists_path
    end
        
    private

    def set_playlist
        @playlist = Playlist.find(params[:id])
    end

    def playlist_params
        params.require(:playlist).permit(:title, :description, :device_id, medium_ids: [])
    end

    def require_same_user
        if current_user != @playlist.user && !current_user.admin?
            flash[:alert] = "You cannot edit or delete others playlists!"
            redirect_to @playlist
        end
    end
end 