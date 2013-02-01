class LogItem < ActiveRecord::Base
  attr_accessible :complete, :content, :milestone, :position, :desc

  belongs_to :log
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  validates :content, presence: true, length: { in: 10..250 }
  validates :desc, length: { in: 0..2000 }
  validates :user_id, presence: true
  validates :log_id, presence: true
  validates :position, presence: true, numericality: true

  # def position=(val)
  #   if self[:position] != val

  #   end
  # end
end
