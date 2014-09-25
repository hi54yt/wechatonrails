class User < ActiveRecord::Base
  after_initialize :set_default_role, :if => :new_record?

  enum role: [:user, :vip, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable




  private

  def set_default_role
    self.role ||= :user
  end
end
