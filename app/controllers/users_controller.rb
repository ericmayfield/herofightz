class UsersController < ApplicationController
    get "/register" do
        if session[:message]
            @message = session.delete(:message)
        end
        erb :register
    end
    
    post "/register" do
        if !params[:email].empty? && !params[:password].empty?
            user = User.create(params)
            user.save
            session[:user_id] = user.id
            redirect "/account"
        else
            session[:message] = "There was an issue please retry."
            redirect '/register'
        end
    end

    get "/account" do
        if session[:user_id]
            @user = User.find(session[:user_id])
            @hero_count = @user.heroes.count
            erb :account
        else
            session[:message] = "You must login to perform this action."
            redirect "/login"
        end
    end

    get "/account/edit" do
        if session[:user_id]
            @user = User.find(session[:user_id])
            erb :'/users/edit'
        else
            session[:message] = "You must login to perform this action."
            redirect "/login"
        end
    end

    patch "/account" do
        if session[:user_id]
            @user = User.find_by(session[:user_id])
            @user.name = params[:name] if !params[:name].empty?
            @user.email = params[:email] if !params[:email].empty?
            @user.password = params[:password] if !params[:password].empty?
            @user.save
            redirect '/account'
        else
            session[:message] = "You must login to perform this action."
            redirect "/login"
        end
    end

    delete "/account/delete" do
        user = User.find(params[:user_id])
        user.destroy
        redirect '/users'
    end

    get "/users" do
        admin_check = User.find_by(email: "eric@visiblycreative.com")
        user_check = User.find(session[:user_id])

        if admin_check == user_check
            @users = User.all
            erb :'/users/index'
        else
            session.clear
            redirect '/'
        end
    end
end