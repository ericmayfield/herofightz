class SessionsController < ApplicationController
    get "/login" do
        if !session[:user_id]
          if session[:message]
            @message = session.delete(:message)
          end
    
          erb :login
        else
          redirect "/account"
        end
      end
    
    post "/login" do
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/account'
        else
            session[:message] = "Incorrect Email or Password"
            redirect '/login'
        end  
    end

    get "/logout" do 
        session.clear
        redirect '/'
    end
end