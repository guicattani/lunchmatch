# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupEmployee do
  describe 'validations' do
    it { is_expected.to belong_to(:group) }
    it { is_expected.to belong_to(:employee) }
  end
end
