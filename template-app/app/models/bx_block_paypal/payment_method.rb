module BxBlockPaypal
  class PaymentMethod < BxBlockPaypal::ApplicationRecord
    def self.paypal
      find_by(slug: 'paypal')
    end
  end
end
