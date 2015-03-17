class Property < ActiveRecord::Base
  belongs_to :model
  validates_presence_of :name
  validates_presence_of :data_type
  validates_uniqueness_of :name, :scope => [:model_id]

  def to_json
    json = {}

    if description.present?
      json["description"] = description
    end

    if allow_multiple
      return to_array_data
    elsif Parameter::DATA_TYPES.include?(:"#{data_type}")
      json["type"] = data_type
    else
      json["$ref"] = "#/definitions/#{data_type}"
    end

    json
  end

  def to_array_data
    json = {
      :type => "array"
    }

    if Parameter::DATA_TYPES.include?(:"#{data_type}")
      json[:items] = {:type => data_type}
    else
      json[:items] = {:'$ref' => "#/definitions/#{data_type}"}
    end

    json
  end

  def to_required_data
  end

end