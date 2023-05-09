class Query
  include ActiveModel::Model

  attr_accessor :contract_ampere, :usage

  validates :contract_ampere,   presence: true,
                                inclusion: { in: %w(10 15 20 30 40 50 60) }

  validates :usage,             presence: true

  def initialize(query_params)
    @contract_ampere = query_params[:contract_ampere]
    @usage = query_params[:usage]
  end

end