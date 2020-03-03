require 'bundler'
Bundler.require

module Concerns
  
  module Findable 
    
    def find_by_name(name)
      final = nil
      self.all.each do |item|
        if item.name == name 
          final = item
        end 
      end 
      final
    end
    
    def find_or_create_by_name(name)
    if find_by_name(name) != nil 
      find_by_name(name)
    else 
      create(name)
    end
  end 
    
  end 
  
end

require_all 'lib'
