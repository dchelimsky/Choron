class Chore < ActiveRecord::Base
  attr_accessible :due_date, :name
  belongs_to :user
  has_one :auction
  accepts_nested_attributes_for :auction
end
