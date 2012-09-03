class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :email, :username, :password, :password_confirmation, :chorons
  has_many :chores
  has_many :bids
  
  def give_chorons(recipient, chorons)
    if(self.chorons >= chorons and chorons >= 0 and self != recipient)
      self.chorons = self.chorons - chorons
      recipient.chorons = recipient.chorons + chorons
      return true if recipient.save and self.save
    end
    return false
  end
end
