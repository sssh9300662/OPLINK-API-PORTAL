class ApisController < ApplicationController
  def show
    @doc = Doc.find params[:doc_id]
    @api = @doc.apis.find_by_path "/"+params[:id]
    respond_to do |f|
      f.html
      f.json { render :json => @api.to_json }
    end

  end
end
