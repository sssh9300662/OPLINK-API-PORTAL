class Resource < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :doc
  has_many :apis, :dependent => :destroy, :order => "sort ASC"
  validates_presence_of :doc_id
  validates_uniqueness_of :name, :scope => [:doc_id]
  include ActsAsSortable

  def to_json
    models_json = {}
    doc.models.each do |model|
      models_json[model.name] = model.to_json
    end
    {
      :id => id,
      :apiVersion => doc.version,
      :swaggerVersion => "1.1",
      :apis => apis.map{ |api| api.to_json },
      :models => models_json
    }
  end

end
