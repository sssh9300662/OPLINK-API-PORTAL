class ErrorResponse < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :api
  validates_uniqueness_of :code, :scope => [:api_id]

  def to_json
    { :code => code,
      :reason => reason
    }
  end  
end
