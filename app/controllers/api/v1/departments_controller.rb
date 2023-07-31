# frozen_string_literal: true

module Api::V1
  class DepartmentsController < ApiController
    # GET /api/v1/departments
    def index
      render json: Department.all.to_json,
             status: :ok
    end

    # POST /api/v1/departments
    def create
      @department = Department.new(department_params)

      if @department.save
        render json: @department.to_json,
               status: :created
      else
        render json: { errors: @department.errors }, status: :unprocessable_entity
      end
    end

    private

    def department_params
      params.permit(:name)
    end
  end
end
