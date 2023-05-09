class Plan
  include ActiveModel::Model
  include PlansLoader

  def initialize
    @plans = load_plans
  end

  def all_plans
    @plans
  end

end
