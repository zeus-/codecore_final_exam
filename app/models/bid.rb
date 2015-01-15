class Bid < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :auction
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0} 
  
  
  #validates_numericality_of :price, :greater_than => Proc.new { |r| r.auction.current_price } 
  #after_initialize :set_default_current_price 
  #after_save :set_current_price
   # def set_default_current_price
  #   current_price ||= 0
  #end
  #has_one :current_price
  #after_initialize :set_default_current_price 
  
 # after_save :set_price
  #validates :price, :numericality => { :greater_than => lambda { |x| x.current_price } }
  #validate :my_attr_is_within_range
  #validates_uniqueness_of :price, :scope => [:current_price]

  #def my_attr_is_within_range
   # if price < current_price
    #  errors.add(:price, "can't less than current")
   # end
  #end

 # def set_price
  #  self.price = self.auction.price
 # end
 # def set_default_current_price
  #    self.current_price ||= 0
 # end

end
