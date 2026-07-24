# バーコードスキャン用（カメラ画面からの API と、暫定の確認用画面）
module Items
  class ScansController < ApplicationController
    # スキャン画面（カメラUIはスタッフ実装。今は動作確認用の素のHTML）
    def new
    end

    # POST /items/scan
    # params: barcode, staff_id
    def create
      result = ItemBarcodeScanner.new(
        user: current_user,
        barcode: params[:barcode],
        staff_id: params[:staff_id]
      ).call

      respond_to do |format|
        format.json do
          if result[:success]
            render json: result, status: :ok
          else
            render json: result, status: :unprocessable_entity
          end
        end
        format.html do
          if result[:success]
            redirect_to scan_path, notice: result[:message]
          else
            redirect_to scan_path, alert: result[:message]
          end
        end
      end
    end
  end
end
