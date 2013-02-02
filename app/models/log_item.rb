class LogItem < ActiveRecord::Base
  attr_accessible :complete, :content, :milestone, :desc

  belongs_to :log
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  validates :content, presence: true, length: { in: 3..250 }
  validates :desc, length: { in: 0..2000 }
  validates :user_id, presence: true
  validates :log_id, presence: true
  validates :position, presence: true, numericality: true, uniqueness: { scope: :log_id }

  before_validation :assign_position, on: :create, if: Proc.new{|li| li.position.blank? }

  scope :at_or_after_position, ->(pos){ where(["log_items.position >= ?", pos]) }
  scope :at_or_before_position, ->(pos){ where(["log_items.position <= ?", pos]) }

  def update_position(new_pos)
    new_pos = new_pos.to_i
    if self[:position] != new_pos
      LogItem.update_all({position: new_pos}, {id: id})
      
      old_pos = self.position
      
      items = nil
      pos = nil
      items = if new_pos > old_pos
        pos = old_pos - 1
        log.log_items.at_or_after_position(old_pos)
      else
        pos = new_pos
        log.log_items.at_or_before_position(old_pos)
      end
      
      items.each do |item|
        pos +=1
        LogItem.update_all({position: pos}, {id: item.id}) unless item == self
      end

    end
  end

private

  def assign_position
    self.position = log.log_items.count
  end

end
