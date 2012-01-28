class Pagamento
   include Mongoid::Document

   field :associado_id
   field :nome
   field :email
   field :datapagamento
   field :valor
   field :comentario
   field :dataregistro
   field :diavencimento
   field :status

end
