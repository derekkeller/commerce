class ApplicationController < ActionController::Base
  protect_from_forgery

  # layout :define_layout
  # 
  # def define_layout
  #   if current_user.admin == true
  #     'pages'
  #   else
  #     'pedros'
  #   end
  # end


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
