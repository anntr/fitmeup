class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by login: params[:login][:login]

    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "zalogowany"
    else
      flash[:alert] = "Niepoprawny login lub hasło"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "wylogowano"
  end

  def session_params
    params.require(:login).permit(:login, :email, :password)
  end
end