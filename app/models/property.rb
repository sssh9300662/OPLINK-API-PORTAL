class Property < ActiveRecord::Base
  belongs_to :model
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:model_id]

  def to_json
    json = {
      :type => data_type
    }
    json[:description] = description if description.present?
    if allowable_values.present?
      json[:allowableValues] = {
          :valueType => "LIST",
          :values => allowable_values.gsub(", ", ",").split(",")
      }
    end
    json
  end
end