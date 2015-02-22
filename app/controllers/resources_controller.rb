class ResourcesController < ApplicationController

  include ForeignDomain::Base

  def show
    @resource = @doc.resources.find_by_name params[:name]
    respond_to do |f|
      f.html { render :json => @resource.to_json }
      f.json { render :json => @resource.to_json }
    end

  end
end
