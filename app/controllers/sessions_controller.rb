class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])

      # raise user.authenticate.inspect
      # abort user.inspect

      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user      
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # if params[:session][:remember_me] == '1'
      #   remember(user)
      # else
      #   forget(user)
      # end
      
      remember user
      redirect_to user
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid Email and Password'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
