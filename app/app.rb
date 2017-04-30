require 'sinatra'
require './lib/game'
require './lib/player'

class RockPaperScissors < Sinatra::Base
  before do
    @game = Game.current
    @actors = Game.country
  end

  get '/' do
    @actors = Game.default
    erb(:index)
  end

  get '/french' do
    @actors = Game.french
    erb(:index)
  end

  get '/english' do
    @actors = Game.english
    erb(:index)
  end

  post '/play' do
    @game.add_player_two(Player.new(params[:player], params[:choice]))
    @game.pick_winner
    erb(:play)
  end

  post '/info' do
    @game = Game.start(Player.new(params[:player], params[:choice]))
    redirect '/player_two' if params[:no_of_players] == 'two_player'
    @game.player_2.generate_response
    @game.pick_winner
    erb(:play)
  end

  get '/player_two' do
    erb(:player_two_choice)
  end
end
