# - class ApiController < ApplicationController
# 我们会把 API 用途的 controller 都继承自 ApiController，而不是ApplicationController。
# 这是因为 API 不需要 protect_from_forgery with: :exception 这一行的 CSRF 浏览器安全检查。
class ApiController < ActionController::Base
  before_action :authenticate_user_from_token!

  def authenticate_user_from_token!

    if params[:auth_token].present?
      user = User.find_by_authenication_token(params[:auth_token])

      # TODO: store false meaning
      sign_in(user, store: false) if user
    end
  end
end
