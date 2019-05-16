
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    new = Article.create(title: params[:title], content: params[:content])
  #create a new object and store it in db while rendering on index
    redirect "/articles/#{new.id}"
  end

  get '/articles' do
    # grab all instances of articles, store in local variable, render them in index
    @article_all = Article.all
    erb :index
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    # @render_article = Article.find(params[:id])
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    id = params[:id]
    title = params[:title]
    content = params[:content]
    Article.update(id, :title => title, :content => content)

    redirect "/articles/#{params[:id]}"
  end

  delete '/articles/:id' do
    Article.destroy(params[:id])

    redirect "/articles"
  end

end
