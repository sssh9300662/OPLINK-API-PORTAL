class DocsController < ApplicationController
  
  #!include ForeignDomain::Base

  def show
    @doc = Doc.find_by_name params[:name]
    respond_to do |f|
      f.html { render :layout => false}
      f.json { render :json => @doc.to_json }
    end
  end
end
