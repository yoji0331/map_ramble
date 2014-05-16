class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_required
    raise Forbidden unless user_signed_in?
  end

  def admin_login_required
    raise Forbidden unless current_user.try(:admin?)
  end

  def current_my_map
    if user_signed_in?
      my_map = current_user.my_map
    elsif session[:my_map_id].present?
      my_map = MyMap.where(id: session[:my_map_id]).last
    end

    unless my_map.present?
      if user_signed_in?
        my_map = current_user.create_my_map
      else
        my_map = MyMap.create
      end
      session[:my_map_id] = my_map.id
    end
    my_map
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
