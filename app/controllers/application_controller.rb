class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters,if: :devise_controller?
  # prepend_before_action :check_captcha

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(
        :sign_up,keys:[
        :name,
        :sex,
        :postcode,
        :prefecture_code,
        :address_city,
        :address_street,
        :address_building
        ]
      )
    end

  # def check_captcha
  #   self.resource = resource_class.new sign_up_params
  #   resource.validate
  #   unless verify_recaptcha(model: resource)
  #     respond_with_navigational(resource) { render :new }
  #   end
  # end
end