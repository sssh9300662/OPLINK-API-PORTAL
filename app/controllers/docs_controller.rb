class DocsController < ApplicationController
   before_filter:set_access 
  #!include ForeignDomain::Base
  
  def set_access
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Request-Method"] = "*"
  end

  def show
    @doc = Doc.find_by_name params[:name]
    respond_to do |f|
      f.html { render :layout => false}
      f.json { render :json => @doc.to_json }
    end
  end
end
