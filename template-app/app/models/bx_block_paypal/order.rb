module BxBlockPaypal
  class Order < BxBlockPaypal::ApplicationRecord
    has_many :order_transactions
  end
end
