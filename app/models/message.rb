class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :legal_case, optional: true

  validates :sender, presence: true
  validates :receiver, presence: true
  validates :content, presence: true
end
