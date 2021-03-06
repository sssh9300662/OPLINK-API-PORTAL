class Model < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :doc
  has_many :properties, :dependent => :destroy
  accepts_nested_attributes_for :properties, :allow_destroy => true
  validates_uniqueness_of :name, :scope => [:doc_id]
  validates_presence_of :name
  validates_presence_of :doc_id

  def to_json
    properties_json = {}

    properties.each do |property|
      properties_json[property.name] = property.to_json
    end

    required_properties = Array.new

    properties.where("required = 1").find_each do |property|
      required_properties.push(property.name)
    end

    json = {}
    json[:required] = required_properties  if !required_properties.empty?
    json[:properties] = properties_json if properties_json.size > 0
    json
  end

end
