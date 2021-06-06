class UsersController < ApplicationController

   def index
       @users = User.all
       render :index
   end

   def new 
        @user = User.new
        render :new

   end 

   def edit
        @user = User.find_by(:id, params[:id])
        render :edit
   end

   def create
        @user = User.new(user_params)
        if @user.save
            login(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages 
            render :new
        end 

   end 

   def show
        @user = User.find_by(:id, parmas[:id])
        render :show           
   end

   def update

        @user = User.update(user_params)
        if @user.save
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :edit 
        end 
       
   end

   def destroy
        @user = User.find_by(:id, parmas[:id])
        @user.destroy
        redirect_to users_url
        
   end

   def user_params
    params.require(:user).permit(:username, :password)
   end 
end
