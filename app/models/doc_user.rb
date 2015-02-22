class DocUser < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_uniqueness_of :user_id, :scope => :doc_id
  belongs_to :user, :counter_cache => :cooperated_docs_count
  belongs_to :doc, :counter_cache => :cooperated_users_count
end
