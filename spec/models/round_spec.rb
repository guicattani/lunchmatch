# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Round do
  describe 'validations' do
    it { is_expected.to have_many(:groups) }
  end

  describe 'on create' do
    it 'creates a random name if none is given' do
      round = described_class.create(name: 'test')
      expect(round.name).to eq('test')

      round = described_class.create
      expect(round.name).not_to be_nil
    end

    describe 'match employees' do
      context 'when Employee count is less than 2' do
        it do
          expect { described_class.create }.not_to change(Employee, :count)
        end

        it do
          create(:employee)
          expect { described_class.create }.not_to change(Employee, :count)
        end
      end

      context 'when Employee count is bigger than 0' do
        let!(:employee) { create(:employee) }
        let!(:employee_two) { create(:employee) }

        it 'creates a group' do
          expect do
            described_class.create
          end.to change(Group, :count).by(1).and(change(GroupEmployee, :count).by(2))
        end

        it 'selects one random leader' do
          described_class.create

          expect(Group.last.group_employees.pluck(:leader)).to include(true)
        end
      end

      context 'when Employee count is 2' do
        let!(:employee) { create(:employee) }
        let!(:employee_two) { create(:employee) }

        it 'creates a group and two group_employees' do
          expect do
            described_class.create
          end.to change(Group, :count).by(1).and(change(GroupEmployee, :count).by(2))
        end
      end

      context 'when Employee count is an odd number' do
        let!(:employees) { create_list(:employee, 4) }
        let!(:employees_two) { create_list(:employee, 3) }

        it 'doesn\'t leave any employee out' do
          described_class.create

          expect(Group.all.map(&:employees).flatten.count).to eq(Employee.count)
        end
      end

      context 'when a Round was already done' do
        let!(:employee) { create(:employee) }
        let!(:employee_two) { create(:employee) }

        it 'chooses different leaders' do
          described_class.create
          described_class.create

          expect(Group.first.group_employees.find_by(leader: true).employee_id).not_to(
            eq(Group.last.group_employees.find_by(leader: true).employee_id)
          )
        end
      end
    end
  end
end
