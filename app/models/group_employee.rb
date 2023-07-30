# frozen_string_literal: true

class GroupEmployee < ApplicationRecord
  belongs_to :employee, -> { includes(:department).group('departments.id') }
  belongs_to :group

  validates_presence_of :employee_id, :group_id
end
