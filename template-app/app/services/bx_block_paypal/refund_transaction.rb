module BxBlockPaypal
  class RefundTransaction < PaypalBase

    # @param @order_transaction[Any] A class instance with
    #   refund! & payment_refund_id & payment_capture_id defined
    def initialize(order_transaction = nil)
      super()
      @order_transaction = order_transaction
    end

    def execute
      request = PayPalCheckoutSdk::Payments::CapturesRefundRequest::new(
          @order_transaction.payment_capture_id
      )
      begin
        response = @client.execute(request)
        result = response.result
        @order_transaction.refund!(result.id)
        {status: :ok, result: @order_transaction}
      rescue PayPalHttp::HttpError => ioe
        {status: :unprocessable_entity, result: ioe.result}
      end
    end
  end
end
