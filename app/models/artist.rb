class Artist < ApplicationRecord
  has_many :records
  validates_presence_of :name, :hot_100_hits
end