class Model < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :doc
  has_many :properties, :dependent => :destroy
  accepts_nested_attributes_for :properties, :allow_destroy => true
  validates_uniqueness_of :name, :scope => [:doc_id]
  validates_presence_of :name
  validates_presence_of :doc_id

  def to_json
    hash_properties = {}
    properties.each do |property|
      hash_properties[property.name] = property.to_json
    end
    json = {
      :id => name
    }
    json[:properties] = hash_properties if hash_properties.size > 0
    json
  end
end
