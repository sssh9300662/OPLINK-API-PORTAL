class Admin::BaseController < ApplicationController
  before_filter :authenticate_user!

  private

  def authenticate_and_find_doc!
    if doc_id = (params[:controller] == "admin/docs" ? params[:id] : params[:doc_id])
      @doc = current_user.docs.find(doc_id) rescue current_user.cooperated_docs.find(doc_id)
      redirect_to admin_docs_path, :notice => "You have no permission" if can_not?(:destroy, @doc)
    end
  end

  # TODO cancan
  def can_not?(action, instance)
    !current_user.owned?(instance) && params[:action] == action.to_s
  end

end
