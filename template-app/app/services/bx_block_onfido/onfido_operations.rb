module BxBlockOnfido
  class OnfidoOperations
    def call
      Onfido::API.new(
        api_key: "api_sandbox.VfzFDCaYox9.rTHqR4jClR6-IHzdAQQUML5bd7PlNZ_Q" || ENV['ONFIDO_API_KEY'] ,
        region: :eu
      )
    end
  end
end