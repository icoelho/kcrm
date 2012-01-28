class Usuario
   include Mongoid::Encryptor
   include Mongoid::Document

   field :email
   field :nome
   field :password_hash
   field :password_salt
   field :status
   field :acessos
   encrypts :password_hash
 
end

