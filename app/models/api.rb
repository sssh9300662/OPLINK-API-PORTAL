class Api < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :resource
  delegate :doc, :to => :resource
  has_many :parameters, :dependent => :destroy
  accepts_nested_attributes_for :parameters, :allow_destroy => true
  has_many :error_responses, :dependent => :destroy
  accepts_nested_attributes_for :error_responses, :allow_destroy => true
  validates_presence_of :path
  validates_presence_of :resource_id
  validates_presence_of :doc_id
  validates_presence_of :http_method
  validates_uniqueness_of :path, :scope => [:doc_id, :http_method]
  HTTP_METHODS = [:get, :post, :put, :delete]
  CONSUME_TYPES = [ "none", "application/json", "application/xml", "application/json, application/xml", "application/x-www-form-urlencoded"]
  PRODUCE_TYPES = [ "none", "application/json", "application/xml", "application/json, application/xml"]
  before_validation :sync_doc_id

  def to_api_json
    api_json = {
      :tags => [resource.name],
      :summary => summary,
      :description => note,
      :operationId => "#{http_method}#{path}",
      :responses => to_responses
    }

    if !(consume_type.eql? "none" or consume_type == nil)
      api_json["consumes"] = to_consumes
    end

    if !(produce_type.eql? "none" or produce_type == nil)
      api_json["produces"] = to_produces
    end

    if !parameters.empty?
      api_json["parameters"] = to_parameters
    end
    
    return api_json
  end

  def to_responses
    responses_json = {}
    error_responses.each do |error_response|
      responses_json[error_response.code] = error_response.to_json
    end

    if response_class != nil
      responses_json[200] = to_success_response
    end

    responses_json
  end

  def to_response_schema
    model = doc.models.where("name = '#{response_class}'").first

    if model == nil
    {
      :type => response_class
    }
    else
    {
      :'$ref'=> "#/definitions/#{response_class}"
    }
    end
  end

  def to_success_response
    model = doc.models.where("name = '#{response_class}'").first
    success_response_json = {
      :schema => to_response_schema
    }

    if model != nil
      success_response_json["description"] = model.description
    end
    
    success_response_json
  end

  def to_parameters
    parameters_array = Array.new
    parameters.each do |parameter|
      parameters_array.push(parameter.to_json)
    end
    return parameters_array
  end

  def to_consumes
    return consumes_array = consume_type.split(", ")
  end

  def to_produces
    return produce_type.split(", ")
  end

  def to_json
    apis_json = {}
    doc.apis.where("path = '#{path}'").find_each do |api|
    apis_json[api.http_method] = api.to_api_json
    end
    apis_json
  end

  private 

  def nickname
    "api_#{id}"
  end

  def sync_doc_id
    self.doc_id = resource.doc_id unless doc_id
  end

end
