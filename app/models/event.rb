class Event < ApplicationRecord
  belongs_to :permission
  has_many :eventlogs
end