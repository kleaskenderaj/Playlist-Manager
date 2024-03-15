class MediumsController < ApplicationController

    before_action :set_medium, only: [:edit, :show, :update, :destroy]
    before_action :require_user, expect: [:show]


    def index 
        @medium = Medium.all
        @medium = @medium.filter_by_title(params[:search]) if params[:search].present?
    end

    def new 
        @medium = Medium.new 
    end

    def edit

    end

    def create
        @medium = Medium.new
        @medium.assign_attributes(create_params.except(:playlist_ids))
        if @medium.save
            Array(create_params[:playlist_ids]).compact.each do |playlist_id|
              next unless playlist_id.present?
              PlaylistItem.create(medium_id: @medium.id, playlist_id: playlist_id)
            end          
            flash[:notice] = "New medium was added"
            redirect_to mediums_path
        else
            render "new"
        end
    end

    def show 

    end

    def update
        puts "params: #{}"
        if @medium.update(create_params)
            flash[:notice] = "Medium was updated"
            redirect_to @medium
        else 
            render 'edit'
        end
    end

    def destroy
        @medium.destroy
        redirect_to mediums_path
    end  

    private 

    def set_medium
        @medium = Medium.find(params[:id])
    end

    def create_params
        params.permit(:title, :description, :content_url, playlist_ids: []) #:playlist_id)
    end


end
