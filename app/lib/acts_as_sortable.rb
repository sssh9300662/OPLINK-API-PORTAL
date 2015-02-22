module ActsAsSortable
  extend ActiveSupport::Concern
  
  included do
    send(:acts_as_sortable)
  end
  
  module ClassMethods
    
    def acts_as_sortable
      acts_as_list :column => :sort, :add_new_at => :bottom, :scope => :doc_id
    end
    
    
  end
  
  module InstanceMethods
    

  end
  
end