# frozen_string_literal: true

module Api::V1
  class RoundsController < ApiController
    # GET /api/v1/rounds
    def index
      render json:
        GroupEmployee.all
                     .includes(:employee, :group)
                     .to_json(only: %i[leader], include:
              { employee: { only: %i[name id], include: { department: { only: :name } } },
                group: { only: %i[id], include: {
                  round: { only: %i[name id] }
                } } }),
             status: :ok
    end

    # POST /api/v1/rounds
    def create
      Round.create

      render json:
        GroupEmployee.last
                     .to_json(only: %i[leader], include:
              { employee: { only: %i[name id], include: { department: { only: :name } } },
                group: { only: %i[id], include: {
                  round: { only: %i[name id] }
                } } }),
             status: :created
    end
  end
end
