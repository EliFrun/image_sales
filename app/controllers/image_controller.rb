class ImageController < ApplicationController

    before_action :set_image, only: [:show, :update, :destroy]

    # GET /image
    def index
      @images = Image.all
      resp = @images.map do |im|
        {
          id: im[:image_id],
          image_id: im[:image_id],
          name: im[:name],
          owner: im[:owner],
          price: im[:price],
          properties: im[:properties]
        }
      end
      json_response({images: resp})
    end
  
    # POST /image
    def create
      images = JSON.parse(request.body.read).deep_symbolize_keys![:images]
      image_list = []
      images.each do |im|
          # all keys present
          if !%i[image_id name owner price properties].all? {|s| im.key? s} then
            next
          end
          # user exists
          if !User.find_by(user_id: im[:owner]) then
            next
          end
          if Image.find_by(image_id: im[:image_id]) then
            next
          end
          Image.create!(
            id: im[:image_id],
            image_id: im[:image_id],
            name: im[:name],
            owner: im[:owner],
            price: im[:price],
            properties: im[:properties].to_s
          )
          im[:properties].each do |p|
            Property.create!(
              id: Digest::SHA256.hexdigest("#{im[:image_id]}_#{p}")[0..6].to_i(16),
              property_id: Digest::SHA256.hexdigest("#{im[:image_id]}_#{p}")[0..6].to_i(16),
              name: p,
              image: im[:image_id]
            )
          end
          image_list << im[:name]
      end
      json_response({created: image_list}, :created)
    end
  
    # GET /image/:id
    def show
      @Image = Image.find_by(image_id: params[:id])
      if !@Image then
        return json_response({r: "image does not exist"})
      end
      json_response(
        {
          id: @Image[:image_id],
          image_id: @Image[:image_id],
          name: @Image[:name],
          owner: @Image[:owner],
          price: @Image[:price],
          properties: @Image[:properties]
        }
      )
    end
  
    # PUT /image/:id
    def update
      head :no_content
    end
  
    # DELETE /image/:id
    def destroy
      Property.where("image = #{params['id']}").all.each do |p|
        p.destroy!
      end
      Image.find_by(image_id: params['id']).destroy
      json_response({success: "image deleted successfully"})
    end
  
    private
  
    def image_params
      # whitelist params
      params.permit(:title, :created_by)
    end
  
    def set_image
      @image = Image.find(params[:id])
    end
end
