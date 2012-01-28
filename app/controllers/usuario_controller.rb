class UsuarioController < ApplicationController
  
  layout nil
  
 
  # Save a new user
  def save
    
    # create a user
    c = Usuario.new
    c.email = "mylene.coelho@gmail.com"
    c.password_hash = 'this is a secret'
    c.password_hash.encrypted?
    c.save
    
  end
  
  def authenticate
    digitado = params[:senha]
    email = params[:email]
    user = Usuario.where(:email => email).first
    
    if user
        if user.password_hash == digitado
            session[:userId] = user.id
            redirect_to "/associado/all"
        else
            redirect_to "/usuario/login"
        end
    else
        redirect_to "/usuario/login"
    end
  end
  
  
  # clear the session
  def logout
    if session[:userId]
      reset_session
    end
    redirect_to '/usuario/login'
  end
  
  def login
    render "_loginUser"
  end
  
  def register
    render "_register"
  end
  
  
  def registered
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
			
      
      render "_thankyou"

  end
  
  
end

