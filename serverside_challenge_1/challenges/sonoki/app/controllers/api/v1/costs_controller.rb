class Api::V1::CostsController < ApplicationController
  include PlansLoader

  def index
    render json: {
      status: 'SUCCESS',
      message: '電力会社とコスト一覧の取得に成功しました',
      data: Plan.new.all_plans
    }, status: 200
  end

  def calculate_rate
    @query = Query.new(query_params)
    if @query.valid?
      @costs = Cost.calculate(@query)
      render json: @costs, status: 200
    else
      render json: { error: 'Invalid input: contract_ampere and usage are required' }, status: 400
    end
  end

  private

  def query_params
    params.permit(:contract_ampere, :usage).to_h.with_indifferent_access
  end

end
