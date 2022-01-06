class PropertyController < ApplicationController
  
  # GET /propertys
  def index
    @properties = Property.all
    resp = @properties.map do |p|
      {
        name: p[:name],
        image: p[:image]
      }
    end
    json_response(resp)
  end

  # POST /propertys
  def create
    @property = Property.create!(property_params)
    json_response(@property, :created)
  end

  # GET /propertys/
  def show
    @property = Property.where("name = '#{params['name']}'").all
    resp = @property.map do | p |
      {
        name: p[:name],
        image: p[:image]
    }
    end
    json_response(resp)
  end

  # PUT /propertys/:id
  def update
    @property.update(property_params)
    head :no_content
  end

  # DELETE /propertys/:id
  def destroy
    @property.destroy
    head :no_content
  end

  private

  def property_params
    # whitelist params
    params.permit(:title, :created_by)
  end

  def set_property
    @property = Property.find(params[:id])
  end

end
