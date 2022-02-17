class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :movie, presence: true, uniqueness: { scope: :list,
                                                  message: 'should appear only once in a list' }
  validates :list, presence: true
  validates :comment, length: { minimum: 6 }
  validates_associated :movie
end
