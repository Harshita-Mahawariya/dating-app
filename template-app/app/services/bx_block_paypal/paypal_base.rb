module BxBlockPaypal
  class PaypalBase
    def initialize
      paypal = PaymentMethod.paypal
      client_id = paypal.try(:client_id) || ENV['PAYPAL_CLIENT_ID']
      client_secret = paypal.try(:client_secret) || ENV['PAYPAL_CLIENT_SECRET']
      environment = paypal_environment(client_id, client_secret)
      @client = PayPal::PayPalHttpClient.new(environment)
    end

    private

    def paypal_environment(client_id, client_secret)
      if Rails.env.production?
        PayPal::LiveEnvironment.new(client_id, client_secret)
      else
        PayPal::SandboxEnvironment.new(client_id, client_secret)
      end
    end
  end
end
