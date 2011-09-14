module SimpleCaptcha #:nodoc
  module ViewHelper #:nodoc
    def show_simple_captcha(options={})
      key = simple_captcha_key(options[:object])
      options[:field_value] = set_simple_captcha_data(key, options)
      session[:captcha]=key

      defaults = {
         :image => simple_captcha_image(key, options),
         :label => options[:label] || I18n.t('simple_captcha.label'),
         :field => simple_captcha_field(options)
         }

      render :partial => 'simple_captcha/simple_captcha', :locals => { :simple_captcha_options => defaults }
    end
  end
end