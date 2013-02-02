class Log < ActiveRecord::Base
  attr_accessible :name

  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :collaborations, dependent: :destroy
  has_many :users, through: :collaborations
  has_many :log_items, dependent: :destroy, order: "log_items.position ASC"

  validates :name, presence: true, length: { in: 3..100 }
  validates :user_id, presence: true

  after_create :add_collaboration_for_creator

  def reset_positions
    log_items.each_with_index{|li, i| li.update_attribute :position, i }
  end

private

  def add_collaboration_for_creator
    users << creator
  end

end
