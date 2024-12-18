# frozen_string_literal: true

class Position < ApplicationRecord
  validates :name, presence: true

  belongs_to :department
  has_many :functions, dependent: :destroy
end
