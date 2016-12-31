class CustomFailure < Devise::FailureApp

include ApplicationHelper

  def redirect_url
    new_user_session_url(:subdomain => 'secure')
  end

  # Redirect to root_url
  def respond
    if http_auth?
      http_auth
    else
      #set_flash_message(:alert, 'Ya eu un problème !!!')
      store_location!
      #flash[:alert] = i18n_message
      flash_message(:alert, i18n_message)
      #flash[:alert] = i18n_message unless flash[:notice]
      #flash[:alert] = i18n_message
      redirect_to request.referrer
      #, :flash => { :alert => "Insufficient rights!"  }
    end
  end
end