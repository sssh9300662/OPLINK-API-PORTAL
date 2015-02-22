class ForeignDomain::Route
  def self.matches?(request)
    if ([nil, 'localhost', Setting.host] + Setting.multiple_hosts).include?(request.host)
      false
    else 
      true
    end
  end
end