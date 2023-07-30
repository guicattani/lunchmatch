# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group do
  describe 'validations' do
    it { is_expected.to have_many(:group_employees) }
    it { is_expected.to have_many(:employees) }
  end
end
