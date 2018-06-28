class Node < ApplicationRecord
  belongs_to :node, optional: true
  belongs_to :user
  has_many :topics
  validates :name, :slug, presence: true
  validates :name, :slug, uniqueness: true

  second_level_cache expires_in: 90.seconds
  after_commit {Rails.cache.delete_matched("#{self.class}*")}

  def to_param
    slug
  end
end
