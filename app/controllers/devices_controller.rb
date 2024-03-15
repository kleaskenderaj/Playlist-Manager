class DevicesController < ApplicationController
    before_action :require_user, expect: [:show]

    def show
        @device = Device.find(params[:id])
    end

    def index 
        @device = Device.all
    end

    def new
        @device = Device.new
    end

    def create
        if logged_in?
            @device = current_user.devices.build(params.require(:device).permit(:name, :unique_identifier))
            if @device.save
                flash[:notice] = "New device was added"
                redirect_to device_path(@device)
            else
                render "new"
            end
            else
            flash[:alert] = "You need to sign up to create a device"
            redirect_to signup_path
        end
    end


    def edit
        @device = Device.find(params[:id])
    end

    
    def update 
        @device = Device.find(params[:id])
        if @device.update(params.require(:device).permit(:name, :unique_identifier))
            flash[:notice] = "Device was updated succesfully!"
            redirect_to @device
        else
            render 'edit'
        end
    end

    def destroy 
        @device = Device.find(params[:id])
        if @device.destroy
          flash[:success] = "Device deleted successfully"
        else
          flash[:error] = "Error deleting device"
        end
        redirect_to devices_path
    end
      

end
