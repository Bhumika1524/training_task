class User < ApplicationRecord
  has_many :from, class_name: 'Task', foreign_key: 'from_id', dependent: :destroy
  has_many :to, class_name: 'Task', foreign_key: 'to_id', dependent: :destroy
  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
