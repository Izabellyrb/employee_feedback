# frozen_string_literal: true

class Department < ApplicationRecord
  validates :name, presence: true

  has_many :positions, dependent: :destroy
end
