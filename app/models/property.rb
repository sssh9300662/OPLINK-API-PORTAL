class Property < ActiveRecord::Base
  belongs_to :model
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:model_id]

  def to_json
    json = {}

    if description.present?
      json["description"] = description
    end

    if allow_multiple
      json["type"] = to_array_data
    else
      json["type"] = data_type
    end
    json
  end

  def to_array_data
    json = {
      :type => "array"
    }

    if Parameter::DATA_TYPES.include?(data_type)
      json[:items] = {:type => data_type}
    else
      json[:items] = {:'$ref' => "#/definitions/#{data_type}"}
    end

  end

end