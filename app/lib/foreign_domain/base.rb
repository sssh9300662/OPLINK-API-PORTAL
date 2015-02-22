module ForeignDomain::Base
  extend ActiveSupport::Concern
  
  included do
    send(:initial)
  end
  
  module ClassMethods
    
    private

    def initial
      before_filter :get_doc_by_request
    end
    
    
  end
  
  module InstanceMethods
    
    private

    def get_doc_by_request
      subdomain = request.subdomain.to_s.split(".").first
      @doc = Doc.find_by_fqdn(request.host) || Doc.find_by_fqdn("#{request.host}:#{request.port}") || Doc.find_by_subdomain(subdomain)
      response.headers["Access-Control-Allow-Origin"] = "*"
      render :text => "", :status => 500 unless @doc
    end

  end

end