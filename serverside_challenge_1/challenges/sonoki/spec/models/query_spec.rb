require 'rails_helper'

RSpec.describe Query, type: :model do
  let(:valid_contract_ampere) { "30" }
  let(:valid_usage) { "100" }

  describe "バリデーション" do
    context "contract_ampere" do
      it "存在する場合、有効であること" do
        query = Query.new(contract_ampere: valid_contract_ampere, usage: valid_usage)
        expect(query).to be_valid
      end

      it "存在しない場合、無効であること" do
        query = Query.new(contract_ampere: nil, usage: valid_usage)
        expect(query).to_not be_valid
      end

      it "範囲内の値である場合、有効であること" do
        valid_values = %w(10 15 20 30 40 50 60)
        valid_values.each do |value|
          query = Query.new(contract_ampere: value, usage: valid_usage)
          expect(query).to be_valid
        end
      end

      it "範囲外の値である場合、無効であること" do
        query = Query.new(contract_ampere: "5", usage: valid_usage)
        expect(query).to_not be_valid
      end
    end

    context "usage" do
      it "存在する場合、有効であること" do
        query = Query.new(contract_ampere: valid_contract_ampere, usage: valid_usage)
        expect(query).to be_valid
      end

      it "存在しない場合、無効であること" do
        query = Query.new(contract_ampere: valid_contract_ampere, usage: nil)
        expect(query).to_not be_valid
      end

      it "0は有効であること" do
        query = Query.new(contract_ampere: valid_contract_ampere, usage: 0)
        expect(query).to be_valid
      end
    end
  end
end
