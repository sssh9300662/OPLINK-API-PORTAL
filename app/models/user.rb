class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable, :recoverable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :docs
  has_many :doc_users
  has_many :cooperated_docs, :through => :doc_users, :source => :doc

  def self.create_by_omniauth(hash, current_user)
    hash = ActiveSupport::HashWithIndifferentAccess.new hash
    user = User.send("find_by_#{hash[:provider]}_id", hash[:uid])
    unless user
      user = current_user || User.find_by_email(hash[:info][:email]) || User.new( :email => hash[:info][:email], :name => hash[:info][:name] )
      user.send("#{hash[:provider]}_id=", hash[:uid])
      user.save!
    end
    user
  end
  
  def password_required?
    return false if facebook_id
    true
  end

  def owned?(doc)
    doc.user_id == id
  end
end
