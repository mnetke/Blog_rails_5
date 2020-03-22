# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :name, presence: true
  validates :comment, length: { minimum: 10 }, if: -> { comment.present? }
end
