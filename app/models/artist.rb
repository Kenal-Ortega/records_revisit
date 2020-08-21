class Artist < ApplicationRecord
  validates_presence_of :name, :hot_100_hits
end