# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Round do
  it { is_expected.to have_many(:groups) }
end
