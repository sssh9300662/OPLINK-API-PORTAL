module ApplicationHelper
  def current_user_friends_collection
    User.all.select{ |u| u.id != current_user.id }.map{ |u| [u.name, u.id] }
  end

  # TODO cancan
  def can?(action, instance)
    current_user.owned?(instance.doc)
  end

end
