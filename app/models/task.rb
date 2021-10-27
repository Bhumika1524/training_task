class Task < ApplicationRecord
  belongs_to :type, class_name: 'TaskType', foreign_key: 'type_id', required: false
  belongs_to :status, class_name: 'TaskStatus', foreign_key: 'status_id', required: false
  belongs_to :to, class_name: 'User', foreign_key: 'to_id', required: false
  belongs_to :from, class_name: 'User', foreign_key: 'from_id', required: false
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, reject_if: :all_blank, allow_destroy: true
  validates_presence_of :name

end
