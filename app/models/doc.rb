class Doc < ActiveRecord::Base
include Rails.application.routes.url_helpers

  validates_presence_of :user_id
  validates_presence_of :name
  validates_presence_of :api_version
  validates_presence_of :request_path

  belongs_to :user
  has_many :resources, :dependent => :destroy, :order => "sort ASC"
  has_many :apis, :dependent => :destroy
  has_many :models, :dependent => :destroy
  has_many :doc_users
  has_many :users, :through => :doc_users

  # before_create :generate_unique_subdomain

  def version
    api_version
  end

  def to_info
    {
      :description => description,
      :version => version,
      :title => "#{name}"
    }
  end
  
  def schemes
    ["http", "https"]
  end

  def to_json
    apis_json = {}
    apis.each do |api|
    apis_json[api.path] = api.to_json
    end

    models_json = {}
    models.each do |model|
    models_json[model.name] = model.to_json
    end

    json = { 
      :swagger => "2.0",
      :info => to_info,
      :host => request_path,
      :basePath => request_path,
      :tags => resources.map{ |resource| { :name => resource.name, :description => resource.description }},
      :schemes => schemes
    }
    if !apis.empty?
      json["paths"] = apis_json
    end

    if !models.empty?
      json["definitions"] = models_json
    end
    return json
  end

end
