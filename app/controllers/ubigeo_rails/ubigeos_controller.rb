module UbigeoRails
  class UbigeosController < ApplicationController    
    respond_to :json
  
    def show
      render json: UbigeoRails::Ubigeo.with_parent(parent_id)
    end
    
    private
    
    def parent_id
      params[:id]
    end
  end
end