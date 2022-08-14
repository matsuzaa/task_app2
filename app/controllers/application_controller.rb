class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception   #CSRF対策コード
    include SessionsHelper
end
