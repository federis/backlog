class Collaboration < ActiveRecord::Base
  attr_accessible :email
  belongs_to :user
  belongs_to :log

  attr_accessor :email

  validates :log_id, presence: true
  validate :ensure_valid_user

private

  def ensure_valid_user
    if !user_id
      if email
        u = User.where(email: email).first
        if u.nil?
          errors[:base] << "No user exists with that email address"
        elsif u.logs.include?(log)
          errors[:base] << "User is already a collaborator"
        else
          self.user = u  
        end
      else
        errors[:base] << "User cannot be blank"
      end
    end
  end
  
end
