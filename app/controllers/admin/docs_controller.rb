class Admin::DocsController < Admin::BaseController
  before_filter :authenticate_and_find_doc!, :except => [:index]
  before_filter{ breadcrumb_doc(@doc) }

  def index
    @docs = current_user.docs
    @cooperated_docs = current_user.cooperated_docs
  end

  def show
  end

  def new
    @doc ||= current_user.docs.new(params[:doc])
  end

  def edit
  end

  def create
    @doc = current_user.docs.new(params[:doc])
    if @doc.save
      redirect_to(params[:redirect_to] || admin_doc_path(@doc), :notice => "create success")
    else
      flash[:error] = @doc.errors.full_messages
      render :new
    end
  end

  def update
    if @doc.update_attributes params[:doc]
      redirect_to(params[:redirect_to] || admin_doc_path(@doc), :notice => "update success")
    else
      flash[:error] = @doc.errors.full_messages
      render :edit
    end
  end

  def destroy
    @doc.destroy
    redirect_to admin_docs_path, :notice => "delete success"
  end

end
