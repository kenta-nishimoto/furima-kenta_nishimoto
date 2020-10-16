class ApplicationController < ActionController::Base
  before_action :basic_auth
  # 上記はベーシック認証のために必須
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # 環境変数を読み込む記述に変更
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:nickname, :email, :birth_date, :first_name, :last_name, :first_name_kana, :last_name_kana]
    #↑　各個人の設定した内容によって変わるので、気をつけてね。
    )
  end
end