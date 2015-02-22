class Doc < ActiveRecord::Base

  validates_presence_of :user_id
  validates_presence_of :name
  validates_presence_of :api_version
  validates_presence_of :request_path

  belongs_to :user
  has_many :resources, :dependent => :destroy, :order => "sort ASC"
  has_many :models, :dependent => :destroy
  has_many :doc_users
  has_many :users, :through => :doc_users

  before_create :generate_unique_subdomain

  def version
    api_version
  end

  def to_json
    { 
      :apiVersion => version,
      :swaggerVersion => "1.1",
      :basePath => "http://#{host_to_json}",
      :requestPath => request_path,
      :apis => resources.map{ |resource| { :id => resource.id, :path => "/#{resource.name}.{format}", :description => resource.description } }
    }
  end

  def host_to_json
    fqdn.present? ? fqdn : "#{subdomain}.#{Setting.host}"
  end

  def preview_link
    "http://#{host_to_json}"
  end

  private

  def generate_unique_subdomain
    begin
      rand ||= SecureRandom.hex(3)
    end while !self.class.count(:conditions => ["subdomain = ?", rand]).zero?
    self.subdomain = rand
  end

end
