# frozen_string_literal: true

FactoryBot.define do
  factory :round do
    name { Faker::Books::Lovecraft.tome }
  end
end
