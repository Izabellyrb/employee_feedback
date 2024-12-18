# frozen_string_literal: true

class Function < ApplicationRecord
  validates :name, presence: true

  belongs_to :position
end
