class LogItem < ActiveRecord::Base
  attr_accessible :complete, :content, :milestone, :desc

  belongs_to :log
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  validates :content, presence: true, length: { in: 3..250 }
  validates :desc, length: { in: 0..2000 }
  validates :user_id, presence: true
  validates :log_id, presence: true
  validates :position, presence: true, numericality: true, uniqueness: { scope: :log_id }, unless: Proc.new{|li| li.position < 0 }

  before_validation :assign_position, on: :create, if: Proc.new{|li| li.position.blank? }

  scope :between, ->(start_pos, end_pos){ where(["log_items.position >= ? AND log_items.position <= ?", start_pos, end_pos])}
  scope :after, ->(pos){ where(["log_items.position > ?", pos])}
  scope :incomplete, ->{ where("log_items.completed_at is NULL")}
  scope :complete, ->{ where("log_items.complete_at is not NULL")}

  def complete=(val)
    self.completed_at = if val == "true" || val == true
      Time.now
    else
      nil
    end
  end

  def complete?
    !completed_at.nil?
  end

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

  def update_positions_for_completed_item
    pos = position
    log.log_items.after(position).each do |item|
      LogItem.update_all({position: pos}, {id: item.id}) 
      pos+=1
    end
    LogItem.update_all({position: -1}, {id: id}) 
  end

private

  def assign_position
    self.position = log.log_items.count
  end

end
