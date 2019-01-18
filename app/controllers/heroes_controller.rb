class HeroesController < ApplicationController
    get '/heroes/new' do
        if session[:user_id]
            erb :'/heroes/new'
        else
            session[:message] = "You must login to perform this action."
            redirect "/login"
        end
    end

    post '/heroes' do
        if session[:user_id]
            hero = Hero.create(params)
            redirect "/heroes/#{hero.id}/show"
        else
            session[:message] = "You must login to perform this action."
            redirect "/login"
        end
    end

    get '/heroes/:id/edit' do
        @hero = Hero.find_by(id: params[:id])

        if session[:user_id] == @hero.user_id
            erb :"/heroes/edit"
        elsif !session[:user_id]
            session[:message] = "You must login to perform this action."
            redirect '/login'
        else
            session[:message] = "The hero you are attempting to edit does not belong to you."
            redirect "/account"
        end
    end
    
    patch '/heroes' do
        if session[:user_id]
            hero = Hero.find_by(id: params[:id])
            hero.name = params[:name]
            hero.img_path = params[:img_path]
            hero.battle_cry = params[:battle_cry]
            hero.bio = params[:bio]
            hero.save
            redirect '/heroes'
        else
            session[:message] = "You must login to perform this action."
            redirect "/login"
        end
    end
    
    get '/heroes' do
        if session[:user_id]
            @heroes = User.find(session[:user_id]).heroes
            @count = @heroes.count
            erb :'/heroes/index'
        else
            session[:message] = "You must login to perform this action."
            redirect "/login"
        end
    end

    delete '/heroes/delete' do
        if session[:user_id]
            hero = Hero.find_by(id: params[:hero_id])
            hero.destroy
            redirect '/heroes'
        else
            session[:message] = "You must login to perform this action."
            redirect "/login"
        end
    end

    get '/heroes/:id/show' do
        if session[:user_id]
            @hero = Hero.find_by(id: params[:id])
            erb :'/heroes/show'
        else
            session[:message] = "You must login to perform this action."
            redirect "/login"
        end
    end
end