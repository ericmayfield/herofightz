require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET')
  end

  get "/" do
    # hero = Hero.find_by(id: "1")
    # hero.destroy
    #Load four latest heroes for homepage
    @heroes_array = Hero.all.to_a
    @heroes = []

    4.times {
      @heroes << @heroes_array.pop
    }

    erb :welcome
  end

  get "/contact" do
    erb :contact
  end
end
