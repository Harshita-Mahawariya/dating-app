module BxBlockPaypal
  class PaypalController < ApplicationController
    # Todo - Just a dummy controller to demo functionality of Paypal Black
    # Ideally should be called by controller of payment block

    def authorize
      order = Order.find_by(id: params[:order_id])
      result = CreateTransaction.new(order, params[:currency_code]).execute
      render json: result.as_json, status: result[:status]
    end

    def capture
      order_transaction = OrderTransaction.find_by(
        id: params[:order_transaction_id]
      )
      result = CaptureTransaction.new(order_transaction).execute
      render json: result.as_json, status: result[:status]
    end

    def refund
      order_transaction = OrderTransaction.find_by(
        id: params[:order_transaction_id]
      )
      result = RefundTransaction.new(order_transaction).execute
      render json: result.as_json, status: result[:status]
    end
  end
end
