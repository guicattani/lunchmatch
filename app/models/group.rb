# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :group_employees, dependent: :destroy
  has_many :employees, foreign_key: "employee_id", through: :group_employees

  belongs_to :round
end
