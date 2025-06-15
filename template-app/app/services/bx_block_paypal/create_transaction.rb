module BxBlockPaypal
  class CreateTransaction < PaypalBase
    DEFAULT_RETURN_URL = 'https://example.com'
    DEFAULT_CANCEL_URL = 'https://example.com?q=cance'

    # @param order[Any] A class instance with total and
    #   association order_transactions defined
    # @param currency_code[String] Currency in which transaction is required
    def initialize(order = nil, currency_code = nil)
      super()
      @order = order
      @currency_code = currency_code || 'USD'
    end

    def execute
      request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
      request.request_body(payment_options)
      begin
        response = @client.execute(request)
        result = response.result
        transaction = @order.order_transactions.create!({
            payment_reference_id: result.id,
            payment_method_id: PaymentMethod.paypal.id
        })
        {status: :ok, result: success_response(result, transaction)}
      rescue PayPalHttp::HttpError => ioe
        {status: :unprocessable_entity, result: ioe.result}
      end
    end

    private

    def payment_options
      {
          intent: 'CAPTURE',
          application_context: {
              return_url: ENV['PAYPAL_RETURN_URL'] || DEFAULT_RETURN_URL,
              cancel_url: ENV['PAYPAL_CANCEL_URL'] || DEFAULT_CANCEL_URL
          },
          purchase_units: [
              {
                  amount: {
                      currency_code: @currency_code,
                      value: @order.total
                  }
              }
          ]
      }
    end

    def success_response(result, transaction)
      {
          links: result.links,
          transaction: transaction
      }
    end
  end
end
