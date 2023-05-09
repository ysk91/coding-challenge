class Cost
  include ActiveModel::Model

  def self.calculate(query)
    contract_ampere = query.contract_ampere
    usage = query.usage

    @plans = Plan.new.all_plans
    costs = []

    @plans.each do |key, values|
      basic_rate = values['basic_rates'][contract_ampere.to_i]
      next unless basic_rate

      usage_total_cost = 0
      remaining_usage = usage.to_i

      values['usage_rates'].each do |rate_info|
        min, max = rate_info['range'].map { |value| value == "inf" ? Float::INFINITY : value }
        difference =  max - min + 1
        if remaining_usage >= difference
          usage_total_cost += rate_info['rate'] * difference
          remaining_usage -= difference
        else
          usage_total_cost += rate_info['rate'] * remaining_usage
          remaining_usage -= remaining_usage
          break
        end
      end
      total_cost = basic_rate + usage_total_cost

      costs << { provider_name: key,
                  plan_name: values['plan_name'],
                  price: total_cost
                }
    end
    costs
  end
end
