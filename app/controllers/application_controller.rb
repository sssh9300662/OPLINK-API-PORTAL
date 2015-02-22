class ApplicationController < ActionController::Base
  protect_from_forgery
  add_crumb("Home"){ |ins| ins.send :root_path }

  private

  def breadcrumb_doc(doc, options = {})
    add_crumb "Docs", doc.present? ? admin_docs_path : nil
    add_crumb (doc.new_record? ? "new" : doc.name), (options[:link] ? admin_doc_path(doc) : nil) if doc
  end

  def breadcrumb_resource(resource, options = {})
    breadcrumb_doc(@doc || resource.doc, :link => true)
    add_crumb "Resources", resource.present? ? admin_doc_resources_path(resource.doc) : nil
    add_crumb (resource.new_record? ? "new" : resource.name), (options[:link] ? admin_doc_resource_path(resource.doc, resource) : nil) if resource
  end

  def breadcrumb_api(api)
    breadcrumb_resource(@resource || api.resource, :link => true)
    add_crumb "Apis", api.present? ? admin_doc_resource_path(api.resource.doc, api.resource) : nil
    add_crumb (api.new_record? ? "new" : api.path) if api
  end

  def breadcrumb_model(model)
    breadcrumb_doc(@doc || model.doc, :link => true)
    add_crumb "Models", model.present? ? admin_doc_models_path(model.doc) : nil
    add_crumb (model.new_record? ? "new" : model.name) if model
  end
end
