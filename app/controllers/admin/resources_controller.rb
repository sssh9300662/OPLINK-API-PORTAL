class Admin::ResourcesController < Admin::BaseController
  before_filter :authenticate_and_find_doc!
  before_filter :get_resource, :except => [:index]
  before_filter{ breadcrumb_resource(@resource) }

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @resource.save
      redirect_to(params[:redirect_to] || admin_doc_resource_path(@doc, @resource), :notice => "create success")
    else
      flash[:error] = @resource.errors.full_messages
      render :new
    end
  end

  def update
    @resource.send params[:sort] if params[:sort]
    if @resource.update_attributes params[:resource]
      redirect_to(params[:redirect_to] || admin_doc_resource_path(@doc, @resource), :notice => "update success")
    else
      flash[:error] = @resource.errors.full_messages
      render :edit
    end
  end

  def destroy
    @resource.destroy
    redirect_to admin_doc_resources_path(@doc), :notice => "delete success"
  end

  private

  def get_resource
    @resource = params[:id] ? @doc.resources.find(params[:id]) : @doc.resources.new(params[:resource])
  end
end
