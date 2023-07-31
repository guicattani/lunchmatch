# frozen_string_literal: true

class Round < ApplicationRecord
  before_create :random_name
  after_create :match_employees

  has_many :groups, -> { includes :group_employees }, dependent: :destroy
  private

  def random_name
    self.name = Faker::Books::Lovecraft.tome if name.nil?
  end

  def match_employees
    return 'groups already matched for this round' unless groups.empty?

    create_new_round
  end

  def create_new_round
    department_employees = query_department_employees
    return if department_employees.empty? || Employee.count <= 1

    new_groups = create_groups
    Employee.count.times do |index|
      employee = sample_random_employee(department_employees, index)
      new_groups[index % new_groups.length].employees << employee
    end

    assign_random_leader(new_groups)
  end

  def assign_random_leader(groups)
    groups.each do |group|
      leader = nil
      tolerance = 0
      while leader.nil?
        group.group_employees.shuffle.each do |group_employee|
          times_as_leader = GroupEmployee.times_as_leader(group_employee.employee_id).count
          leader = group_employee if times_as_leader <= tolerance
        end

        if leader.nil?
          tolerance += 1
        else
          leader.update(leader: true)
          next
        end
      end
    end
  end

  def create_groups
    groups = []
    (Employee.count / ENV['MAX_EMPLOYEES_PER_GROUP'].to_f).ceil.times do
      groups << Group.create(round: self)
    end
    groups
  end

  def sample_random_employee(department_employees, index)
    department_employees.length.times do
      employee = pop_random_employee(
        department_employees[index % department_employees.length]
      )

      return employee if employee

      index += 1
    end
  end

  def pop_random_employee(department_employees)
    department_employees.shuffle.pop
  end

  def query_department_employees
    Department.select('departments.id,
      array_agg(employees.name) AS employees')
              .joins(:employees)
              .group('departments.id')
              .map { |department| department.employees.to_a }
  end
end
