class Auction < ActiveRecord::Base
  belongs_to :user
  has_many :bids
  validates_presence_of :title
  validates :reserve_price, presence: true

  scope :published, -> { where(state: :published) }
  after_initialize :set_default_current_price 
  state_machine :state, initial: :draft do
    event :publish do
      transition draft: :published
    end
    event :reserve do
      transition published: :reserve_met
    end

  end
  private
    def set_default_current_price
      self.current_price ||= 0
    end
  
  #validate :add_to_bids
  # def add_to_bids
  #   if self.bids.price < self.current_price
  #end
end
