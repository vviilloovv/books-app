# frozen_string_literal: true

class Book < ApplicationRecord
  paginates_per 7
end
