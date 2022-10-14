class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id] # Se já foi feita a pesquisa  pegue o usuáro armazenado em @current_user a cada referência do método, se não pesquisa no @user.find
    end

    def logged_in?
        !!current_user  #transforma o usuário atual em boleano, verifica se o usuário está logado
    end

    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        end
    end
end
