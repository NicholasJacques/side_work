class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_verification
  include SessionsHelper
  include AccountActivationsHelper
end
