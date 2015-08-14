module DeviseHelper
  def devise_error_messages!
    if !resource.errors.empty?
      messages = resource.errors.full_messages
      flash[:error] = messages.join('. ') if messages
    end
    return ""
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end