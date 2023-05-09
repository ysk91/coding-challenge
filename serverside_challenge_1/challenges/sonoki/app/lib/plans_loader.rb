module PlansLoader
  def load_plans
    require 'yaml'
    @plans_data ||= YAML.load_file(Rails.root.join('config', 'rates.yml'))
  end
end
