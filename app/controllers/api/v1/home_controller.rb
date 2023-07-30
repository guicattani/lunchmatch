# frozen_string_literal: true

module Api::V1
  class HomeController < ApiController
    # GET /api/v1/home
    def index
      render json: 'hello from the backend'.to_json, status: :ok
    end
  end
end
