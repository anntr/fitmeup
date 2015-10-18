class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :authorize, except: [:authorize, :current_user ]
private

  def authorize
    unless current_user
      flash[:alert]="tylko zalogowni użytkownicy mogą oglądać tę sekcję"
      redirect_to new_session_path
     end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
