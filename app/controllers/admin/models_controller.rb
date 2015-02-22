class Admin::ModelsController < Admin::BaseController
  before_filter :clean_nested_attributes
  before_filter :authenticate_and_find_doc!
  before_filter :get_model, :except => [:index]
  before_filter{ breadcrumb_model(@model) }

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @model.save
      redirect_to(params[:redirect_to] || admin_doc_models_path(@doc), :notice => "create success")
    else
      flash[:error] = @model.errors.full_messages
      render :new
    end
  end

  def update
    @model.send params[:sort] if params[:sort]
    if @model.update_attributes params[:model]
      redirect_to(params[:redirect_to] || admin_doc_models_path(@doc), :notice => "update success")
    else
      flash[:error] = @model.errors.full_messages
      render :edit
    end
  end

  def destroy
    @model.destroy
    redirect_to admin_doc_models_path(@doc), :notice => "delete success"
  end

  private

  def get_model
    @model = params[:id] ? @doc.models.find(params[:id]) : @doc.models.new(params[:model])
  end

  def clean_nested_attributes
    return unless params[:model]
    { :properties => :name }.each do |nested_name, check_field|
      key = "#{nested_name}_attributes"
      next unless params[:model][key]
      params[:model][key] = params[:model][key].select do |k, values|
        values[check_field].present?
      end
    end
  end
end