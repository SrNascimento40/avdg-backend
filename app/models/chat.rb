class Chat < ApplicationRecord
  belongs_to :user_one, class_name: 'User'
  belongs_to :user_two, class_name: 'User'
  has_many   :messages, dependent: :destroy

  # (menor id sempre em user_one)
  before_validation :normalize_users

  validates :user_one, presence: true
  validates :user_two, presence: true
  validates :user_two, comparison: { other_than: :user_one } # evita chat esquizofrênico
  validates :user_one_id, uniqueness: { scope: :user_two_id }

  scope :for_user, ->(user_id) { where("user_one_id = ? OR user_two_id = ?", user_id, user_id) }

  def self.find_or_create_between(user_a_id, user_b_id)
    a, b = [user_a_id, user_b_id].sort
    find_or_create_by!(user_one_id: a, user_two_id: b)
  end

  private

  def normalize_users
    return if user_one_id.blank? || user_two_id.blank?
    a, b = [user_one_id, user_two_id].sort
    self.user_one_id, self.user_two_id = a, b
  end
end
