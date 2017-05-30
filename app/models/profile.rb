
class Profile < ApplicationRecord

  attr_accessor :id, :uid, :name
  
  def Profile.all 
    []
  end
end
