class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # ユーザーがログインしている場合のみ認可する
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインして下さい。"
      redirect_to login_url
    end
  end
  
  # 現在のログインユーザーが管理者かどうか判定
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
  
  # 現在のログインユーザーがユーザー本人であるか判定
  def correct_user
    redirect_to root_url unless current_user?(@user)
  end
  
  # 管理者、またはログインユーザー本人あるか判定
  def admin_or_correct
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
end
