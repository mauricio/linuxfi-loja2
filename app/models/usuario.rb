class Usuario < ActiveRecord::Base

  attr_accessor :senha, :termos_e_condicoes

  before_validation :calcular_senha

  validates_presence_of     :nome, :email

  validates_uniqueness_of   :email

  validates_acceptance_of   :termos_e_condicoes, :if => :new_record?

  validates_presence_of     :senha_em_hash, :if => :senha_necessaria?

  validates_confirmation_of :senha, :if => :senha_necessaria?

  validates_length_of       :senha, :within => 4..40, :if => :senha_necessaria?

  def senha_necessaria?
    !self.senha.blank? || self.senha_em_hash.blank?
  end

  def calcular_senha
    return if self.senha.blank?

    if self.salt.blank?
      hash = "#{Time.now.to_s}-#{self.email}-#{rand(Time.now.to_i)}"
      self.salt = Digest::SHA1.hexdigest( hash )
    end

    self.senha_em_hash = Usuario.hashear_senha(self.senha, self.salt)
  end

  def self.hashear_senha( senha, salt )
    Digest::SHA1.hexdigest( "--#{senha}--#{salt}" )
  end

  def self.autenticar( email, senha )
    usuario = Usuario.where( :email => email ).first

    if usuario && usuario.senha_em_hash == hashear_senha( senha, usuario.salt )
      usuario
    else
      nil
    end
  end

end