ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require './lib/game'
require './lib/player'

class TeamGenerator < Sinatra::Base
  before do
    @game = Game.instance
  end

  get '/' do
    erb :home
  end

  post '/teams' do
    @game = Game.create(params[:players])
    @game.create_players
    @game.assign_teams
    redirect '/teams'
  end

  get '/teams' do
    @team_one = @game.team_one
    erb :teams
  end

  run! if app_file == $PROGRAM_NAME
end
