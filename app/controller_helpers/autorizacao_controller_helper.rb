module AutorizacaoControllerHelper

  def self.included( base )

    base.helper_method :usuario_atual, :logged_in?

  end

  protected

  def logged_in?
    self.usuario_atual
  end

  def usuario_atual
    if @usuario_atual.nil? && !session[:usuario_id].blank?
      @usuario_atual = Usuario.find( session[:usuario_id] )
    end

    @usuario_atual
  end

  def usuario_atual=( novo_usuario )
    session[:usuario_id] = novo_usuario.id
    @usuario_atual = novo_usuario
  end

end


