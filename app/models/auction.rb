class Auction < ActiveRecord::Base
  attr_accessible :expiration_date, :chore_id #explicit use is a bit hacky, oh well
  belongs_to :chore, :counter_cache => true
  has_many :bids
  def lowest()
      self.bids.map{|x| x.amount}.min
  end
end
