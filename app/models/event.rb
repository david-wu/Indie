class Event < ActiveRecord::Base
  validates :owner_id, presence: true
  validates :funds_goal, presence: true
  before_create :set_initial_values
  has_many :perks
  belongs_to :user, class_name: "User", foreign_key: "owner_id"

  def set_initial_values
    self.description ||= 'Missing Description'
    self.funds_raised ||= 0
    self.title ||= 'Missing Title'
    self.img_src ||= 'assets/missing_image.png'
    self.currency ||= 'USD'
    self.body ||= 'Missing Body'
  end

end
