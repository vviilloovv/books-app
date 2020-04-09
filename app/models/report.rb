# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  paginates_per 7
end
