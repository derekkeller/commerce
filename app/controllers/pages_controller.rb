class PagesController < ApplicationController

  layout :right_layout
  
  def index
  end
  
  private
    def right_layout
      if user_signed_in?
        'pages'
      else
        'pedros'
      end
    end

end
