class Parameter < ActiveRecord::Base
  belongs_to :api
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [ :api_id ]
  PARAM_TYPES = [:path, :query, :body, :header, :formData]
  DATA_TYPES = [:string, :number, :boolean, :integer]

  def to_json
    parameter_json = {
      :name => name,
      :in => param_type,
      :required => required
    }
    if description.present?
      parameter_json["description"] = description
    end

    if param_type.eql? "body"
     parameter_json["schema"] = to_schema
    end

    if !param_type.eql? "body" and !allow_multiple
      parameter_json["type"] = data_type
    end

    if !param_type.eql? "body" and allow_multiple
     parameter_json["items"] = {
      :type => data_type
     }
    end

    return parameter_json
  end

  def to_schema
    schema_json = {}
    if(allow_multiple)
     schema_json = {
      :type => "array",
      :items => {
        :'$ref'=> to_model_ref
      }
     }
    else
      schema_json = {
        :'$ref'=> to_model_ref
      }
    end

    return schema_json 
  end

  def to_model_ref
    "#/definitions/#{data_type}"
  end

end
