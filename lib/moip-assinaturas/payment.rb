module Moip::Assinaturas
  class Payment

    class << self

      def list(invoice_id, opts={})
        response = Moip::Assinaturas::Client.list_payments(invoice_id, opts)
        hash     = JSON.load(response.body).with_indifferent_access

        case response.code
        when 200
          return {
            success:  true,
            payments: hash[:payments]
          }
        when 401
          raise(UnauthorizedError, "Você não tem permissão de utilizar o assinaturas")
        else
          raise(WebServerResponseError, "Ocorreu um erro no retorno do webservice")
        end
      end

      def details(id, opts={})
        response = Moip::Assinaturas::Client.details_payment(id, opts)
        hash     = JSON.load(response.body).with_indifferent_access

        case response.code
        when 200
          return {
            success:  true,
            payment:  hash
          }
        when 401
          raise(UnauthorizedError, "Você não tem permissão de utilizar o assinaturas")
        else
          raise(WebServerResponseError, "Ocorreu um erro no retorno do webservice")
        end
      end

    end
  end
end