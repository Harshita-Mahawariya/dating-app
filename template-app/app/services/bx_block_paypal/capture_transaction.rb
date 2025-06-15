module BxBlockPaypal
  class CaptureTransaction < PaypalBase

    # @param @order_transaction[Any] A class instance with
    #   capture! & payment_reference_id & payment_capture_id defined
    def initialize(order_transaction = nil)
      super()
      @order_transaction = order_transaction
    end

    def execute
      request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new(
          @order_transaction.payment_reference_id
      )
      begin
        response = @client.execute(request)
        result = response.result
        @order_transaction.capture!(
            result.purchase_units[0].payments.captures[0].id
        )
        {status: :ok, result: @order_transaction}
      rescue PayPalHttp::HttpError => ioe
        {status: :unprocessable_entity, result: ioe.result}
      end
    end
  end
end
