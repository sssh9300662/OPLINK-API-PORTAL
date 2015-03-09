class Resource < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :doc
  has_many :apis, :dependent => :destroy, :order => "sort ASC"
  validates_presence_of :doc_id
  validates_uniqueness_of :name, :scope => [:doc_id]

end
