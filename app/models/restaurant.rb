# frozen_string_literal: true

class Restaurant < ApplicationRecord
  validates :rating, inclusion: { in: [0, 1, 2, 3, 4],
                                  message: '%{value} is not a valid rating' }

  def to_param
    local_id
  end
end
