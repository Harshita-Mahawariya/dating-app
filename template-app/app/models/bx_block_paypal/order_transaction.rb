module BxBlockPaypal
  class OrderTransaction < BxBlockPaypal::ApplicationRecord
    STATES = {
        initial: 'pending',
        pending_capture: 'pending_capture',
        captured: 'captured',
        refunded: 'refunded',
        failed: 'failed'
    }

    belongs_to :order

    before_create :set_initial_state

    def capture!(payment_capture_id)
      update!(
          payment_capture_id: payment_capture_id,
          state: STATES[:captured]
      )
    end

    def refund!(payment_refund_id)
      update!(
          payment_refund_id: payment_refund_id,
          state: STATES[:refunded]
      )
    end

    private

    def set_initial_state
      self.state ||= STATES.initial
    end
  end
end
