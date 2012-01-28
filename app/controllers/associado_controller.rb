class AssociadoController < ApplicationController
  layout nil
  before_filter :authorize_user
  
  def all
     @associados = Associado.order_by(:nome).limit(50)
     render "_allAssociados"
  end
  
   def search
      word = params[:word].to_s
      @associados = Associado.where(:nome => /#{word}/i).limit(20)
      render "_findAssociados"
   end
   
   def edit
     @associado = Associado.find(params[:id])
     render "_editAssociados"
   end
   
   def payments
     @associado = Associado.find(params[:id])
     @pagamentos = Pagamento.where("associado_id" => params[:id]).order_by(:datapagamento, :desc).limit(20)
     render "_payAssociados"
   end

  def paysave
    t = Time.now
    dataregistro  =  t.strftime("%Y%m%d")
    
    @associado = Associado.find(params[:associadoid])
    pay = Pagamento.new(:associado_id => params[:associadoid] ,
                        :nome => @associado.nome,
                        :email => @associado.email,
                        :datapagamento => dataregistro,
                        :valor => params[:valor],
                        :comentario => params[:comentario],
                        :dataregistro => dataregistro,
                        :diavencimento => @associado.diavencimento,
                        :status => 1)
    pay.save
    @pagamentos = Pagamento.where("associado_id" => params[:associadoid]).order_by(:datapagamento, :desc).limit(20)
    render "_payAssociados"
 
  end
  
  def payinsert
    @associado = Associado.find(params[:id])
    render "_paysaveAssociados"
  end
  
  def new
    render "_saveAssociados"
  end
  
  def save
    t = Time.now
    dataregistro  =  t.strftime("%Y%m%d")
 
    associado = Associado.new(:nome => params[:nome],
                              :profissao => "profissao",
                              :telefones => params[:telefone],
                              :rg => params[:rg],
                              :cpf => params[:cpf],
                              :email => params[:email],
                              :endereco => params[:endereco],
                              :bairro => params[:bairro],
                              :cep => params[:cep],
                              :municipio => params[:municipio],
                              :uf => params[:uf],
                              :datanascimento => params[:nascdata],
                              :municipionascimento => params[:nascmunicipio],
                              :ufnascimento => params[:nascestado],
                              :paisnascimento => "Estrangeiro",
                              :painome => params[:nomepai],
                              :maenome => params[:nomemae],
                              :responsavelcpf => params[:responsavelcpf] ,
                              :responsavelrg => params[:responsavelrg],
                              :fpj_numero => params[:regfpj],
                              :cbj_numero => params[:regcbj],
                              :cadastro => dataregistro,
                              :diavencimento => 1
                             )
    
      associado.save
			
      @associados = Associado.order_by(:nome).limit(50)
      render "_allAssociados"

  end
 
  
end
