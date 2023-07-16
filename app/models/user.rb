class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password,:password_confirmation

  validates_presence_of :email,message: "邮箱不能为空"
  validates :email,uniqueness: true
  validates_format_of :email,message:"邮箱格式不合法",
    with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    if: proc { |user| !user.email.blank? }

  validates_presence_of :password,message: "密码不能为空",if: :need_validate_password
  validates_presence_of :password_confirmation,message: "确认密码不能为空",if: :need_validate_password
  validates_confirmation_of :password,message: "密码不一致",if: :need_validate_password
  validates_length_of :password,message: "密码最短为6位",minimum: 6,if: :need_validate_password

  def username
    self.email.split('@').first
  end

  private

  def need_validate_password
    self.new_record? || (!self.password.nil? || !self.password_confirmation.nil?)
  end
end
