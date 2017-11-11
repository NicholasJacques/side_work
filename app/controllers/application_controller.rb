class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_verification, :check_account_completion
  include SessionsHelper
  include AccountActivationsHelper
end
