class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters,if: :devise_controller?

  def after_sign_in_path_for(resourse)
    case resource
    when User
      root_path
    when Admin
      admin_top_path
    end
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(
        :sign_up,keys:[
        :name,
        :sex,
        :age,
        :postcode,
        :prefecture_code,
        :address_city,
        :address_street,
        :address_building
        ]
      )
    end
end