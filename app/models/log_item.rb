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

  scope :between, ->(start_pos, end_pos){ where(["log_items.position >= ? AND log_items.position <= ?", start_pos, end_pos])}

  def update_position(new_pos)
    new_pos = new_pos.to_i
    if self[:position] != new_pos
      old_pos = self.position

      pos = new_pos > old_pos ? old_pos : new_pos+1
      bounds = [old_pos, new_pos]
      log.log_items.between(bounds.min, bounds.max).each do |item|
        unless item == self
          LogItem.update_all({position: pos}, {id: item.id}) 
          pos+=1
        end
      end

      LogItem.update_all({position: new_pos}, {id: id})
    end
  end

private

  def assign_position
    self.position = log.log_items.count
  end

end
