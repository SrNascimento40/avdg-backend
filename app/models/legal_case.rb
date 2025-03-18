class LegalCase < ApplicationRecord
  belongs_to :client
  belongs_to :lawyer
end
