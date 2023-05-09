require 'rails_helper'

RSpec.describe Plan, type: :model do
  let(:plan) { Plan.new }

  describe '#initialize' do
    it 'yamlデータを呼び出すこと' do
      expect(plan.instance_variable_get('@plans')).not_to be_nil
      expect(plan.instance_variable_get('@plans')).to be_a(Hash)
    end
  end

  describe '#all_plans' do
    it '全てのプランを返すこと' do
      all_plans = plan.all_plans

      expect(all_plans).not_to be_nil
      expect(all_plans).to be_a(Hash)
      expect(all_plans).to eq(plan.instance_variable_get('@plans'))
    end

    it 'yamlデータ通りの形式で値を返すこと' do
      all_plans = plan.all_plans

      all_plans.each do |plan_data|
        expect(plan_data).to be_a(Array)
        expect(plan_data[1]).to be_a(Hash)
        expect(plan_data[1].keys).to include('basic_rates', 'usage_rates')
      end
    end
  end
end
