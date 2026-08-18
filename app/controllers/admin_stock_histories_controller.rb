# 管理画面：入出庫履歴
class AdminStockHistoriesController < ApplicationController
  def index
    @stock_histories = current_user.stock_histories
                                   .includes(:item, :staff)
                                   .order(created_at: :desc)
                                   .page(params[:page])
                                   .per(20)
  end
end
