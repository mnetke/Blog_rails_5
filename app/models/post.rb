# frozen_string_literal: true

class Post < ApplicationRecord
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\z}

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :description, length: { minimum: 160 }, if: -> { description.present? }
end
