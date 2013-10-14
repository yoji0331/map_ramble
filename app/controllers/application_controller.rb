class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_required
    raise Forbidden unless user_signed_in?
  end

  def admin_login_required
    raise Forbidden unless current_user.try(:admin)
  end

  class Forbidden < StandardError; end
  class NotFound < StandardError; end

  rescue_from Forbidden, with: :rescue_403
  rescue_from NotFound, with: :rescue_404

  def rescue_403(exception)
    render "errors/forbidden", status: 403
  end

  def rescue_404(exception)
    render "errors/not_found", status: 404
  end

  def rescue_500(exception)
    render "errors/internal_server_error", status: 500
  end

end
