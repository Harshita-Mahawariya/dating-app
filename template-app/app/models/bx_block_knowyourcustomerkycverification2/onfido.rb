module BxBlockKnowyourcustomerkycverification2
  class Onfido < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_knowyourcustomerkycverification2_onfidos
    enum kyc_status: [:pending, :submitted, :verified, :rejected]
    serialize :onfido_report_id, Array
    serialize :reports_status, Array
    serialize :document_type, Array
  end
end
