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
      :operationId => "#{http_method}#{path}"
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

    if !error_responses.empty?
      api_json["responses"] = to_error_responses
    end
    
    return api_json
  end

  def to_error_responses
    error_responses_json = {}
    error_responses.each do |error_response|
      error_responses_json[error_response.code] = error_response.to_json
    end
    error_responses_json
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
