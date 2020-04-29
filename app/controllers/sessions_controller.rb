class SessionsController < ApplicationController
  def new
  end

  def create
    name = params[:session][:name]
    if login(name)
      flash[:success] = 'ログインに成功しました。'
      redirect_to '/'
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to '/'
  end
  
  private
  
  def login(name)
    @user = User.find_by(name: name)
    if @user
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
