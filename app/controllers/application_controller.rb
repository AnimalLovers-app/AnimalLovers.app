class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    about_path
  end

  def after_sign_out_path_for(resource)
    about_path
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_homes_top_path
    when Customer
      admin_homes_top_path
    else
      admin_homes_top_path
    end
  end
end
