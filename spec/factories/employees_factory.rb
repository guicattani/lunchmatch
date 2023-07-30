# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    name { Faker::Name.neutral_first_name }
    department
  end
end
