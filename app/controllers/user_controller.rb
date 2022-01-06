class UserController < ApplicationController

    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users
    def index
      @users = User.all
      resp = @users.map do |u|
        {
          u[:user_id] => u[:name]
        }
      end
      json_response({users: resp})
    end
  
    # POST /users
    def create
      users = JSON.parse(request.body.read).deep_symbolize_keys![:users]
      user_list = []
      users.each do |u|
        # all keys present
        if !%i[user_id name balance api_key].all? {|s| u.key? s} then
          next
        end
        # user does not already exist
        if User.find_by(user_id: u[:user_id]) then
          next
        end
        User.create!(
          id: u[:user_id],
          user_id: u[:user_id],
          name: u[:name],
          balance: u[:balance],
          api_key: u[:api_key]
        )
        user_list << u[:name]
      end
      json_response({created: user_list}, :created)
    end
  
    # GET /user/:id
    def show
      @User = User.find_by(user_id: params[:id])
      if !@User then
        return json_response({r: "user does not exist"})
      end
      json_response(
        {
          user_id: @User[:user_id],
          name: @User[:name],
          balance: @User[:balance]
        }
      )
    end
  
    # PUT /users/:id
    def update
      @user.update(user_params)
      head :no_content
    end
  
    # DELETE /users/:id
    def destroy
      Image.where("owner = #{params['id']}").all.each do |im|
        Property.where("image = #{im['image_id']}").all.each do |p|
          p.destroy!
        end
        im.destroy!
      end
      User.find_by(user_id: params['id']).destroy
      json_response({success: "user deleted successfully"})
    end
  
    private
  
    def user_params
      # whitelist params
      params.permit(:title, :created_by)
    end
  
    def set_user
      @user = User.find(params[:id])
    end

end
