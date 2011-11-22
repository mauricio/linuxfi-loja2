class BootstrapFormBuilder < ActionView::Base::FormBuilder

  [ :text_field, :text_area, :password_field, :check_box ].each do |method|

    define_method( method ) do |name, *args|
      wrap( name, super(name, *args) )
    end

  end

  def wrap( name, content )
    classes = [ 'clearfix' ]
    error_message = ''
    unless self.object.errors[ name ].blank?
      classes << 'error'
      messages = self.object.errors[ name ].to_sentence
      error_message = %Q!
          <span class="help-inline">#{messages}</span>
      !
    end

    markup = %Q!
      <div class="#{classes.join( ' ' )}">
        <label>#{self.object.class.human_attribute_name( name )}</label>
        <div class="input">
          #{content}
          #{error_message}
        </div>
      </div>
    !

    markup.html_safe
  end

end