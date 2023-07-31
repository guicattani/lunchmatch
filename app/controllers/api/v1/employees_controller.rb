# frozen_string_literal: true

module Api::V1
  class EmployeesController < ApiController
    # GET /api/v1/employees
    def index
      render json: Employee.all
                           .includes(:department)
                           .to_json(include: { department: { only: :name } }),
             status: :ok
    end

    # POST /api/v1/employees
    def create
      @employee = Employee.new(employee_params)

      if @employee.save
        render json: @employee.to_json(include: { department: { only: :name } }),
               status: :created
      else
        render json: { errors: @employee.errors }, status: :unprocessable_entity
      end
    end

    private

    def employee_params
      params.permit(:name, :department_id)
    end
  end
end
