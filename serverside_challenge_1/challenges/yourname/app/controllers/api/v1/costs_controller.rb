class Api::V1::CostsController < ApplicationController
  require 'yaml'

  def index
    if File.exist?(yaml_path)
      yaml_data = YAML.load_file(yaml_path)
      render json: {
        status: 'SUCCESS',
        message: '電力会社とコスト一覧の取得に成功しました',
        data: yaml_data
      }, status: 200
    else
      render json: { error: 'File not found' }, status: 404
    end
  end

  def calculate_rate
    contract_ampere = params[:contract_ampere].to_i
    usage = params[:usage].to_i
    rates = YAML.load_file(yaml_path)
    if contract_ampere && usage
      costs = []
      rates.keys.each do |key|
        basic_rate = rates[key.to_s]['basic_rates'][contract_ampere]
        # usage_rate = rates[key.to_s]['usage_rates']
        usage_rate = nil
        rates[key.to_s]['usage_rates'].each do |rate_info|
          min, max = rate_info['range'].map { |value| value == "inf" ? Float::INFINITY : value }
          if min <= usage && usage <= max
            usage_rate = rate_info['rate']
            break
          end
        end
        total_cost = basic_rate + (usage_rate * usage)

        costs << { 電力会社: key,
                    料金: total_cost
                  }
      end
      render json: costs.to_json, status: 200
    else
      render json: { error: 'Invalid companyname' }, status: 400
    end
  end

  private

  def yaml_path
    Rails.root.join('config', 'rates.yml')
  end
end
