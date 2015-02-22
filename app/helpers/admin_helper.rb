module AdminHelper
  def resource_button_urls(resource)
    doc = resource.doc
    { :up => admin_doc_resource_path(doc, resource, :sort => :move_higher, :redirect_to => url_for(params)),
      :down => admin_doc_resource_path(doc, resource, :sort => :move_lower, :redirect_to => url_for(params)),
    }
  end

  def api_button_urls(api)
    resource = api.resource
    doc = resource.doc
    { :up => admin_doc_resource_api_path(doc, resource, api, :sort => :move_higher, :redirect_to => url_for(params)),
      :down => admin_doc_resource_api_path(doc, resource, api, :sort => :move_lower, :redirect_to => url_for(params)),
    }
  end

  def render_data_type_selector(doc, options = {})
    options[:html] ||= {}
    options[:html][:class] ||= "input-small"
    options[:html][:data] = { :type => "data-types-selectable", :to => options[:to], :autohide => options[:auto_hide] }
    content_tag(:select, options[:html]) do
      collections = [["-- Normal -- ", Parameter::DATA_TYPES[0..-4]], ["-- Models --", doc.models.map{ |model| model.name } + ["custom"] ], ["-- Containers --", Parameter::DATA_TYPES[-3..-1]] ]
      options_for_select([["-- Data Type --", ""]]) + grouped_options_for_select(collections, :selected => options[:selected])
    end
  end

  def render_data_type_form(form, doc)
    content_tag :span do 
      strs = []
      strs << render_data_type_selector(doc, :selected => form.object.data_type, :to => "[data-type=data-types-value]")
      strs << form.input_field(:data_type, :class => "input-small", :as => :string, :data => { :type => "data-types-value"}, :placeholder => "data type")
      raw strs.join("")
    end
  end

  def hidden_input_redirect_to
    request.env["HTTP_REFERER"].present? ? tag("input", :type => :hidden, :name => :redirect_to, :value => request.env["HTTP_REFERER"]) : ""
  end

  def link_to_create(name, url)
    link_to name, url, :class => "btn btn-primary"
  end

  def link_to_more_resources(doc, limit)
    link_to("...more Resources...", admin_doc_resources_path(doc), :class => "") if doc.resources.size > limit
  end

  def link_to_more_models(doc, limit)
    link_to("...more Models...", admin_doc_models_path(doc), :class => "") if doc.models.size > limit
  end
end
