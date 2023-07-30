# frozen_string_literal: true

class Department < ApplicationRecord
  validates_presence_of :name
  has_many :employees
end
