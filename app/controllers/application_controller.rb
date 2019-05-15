
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @articles = Article.all
    erb :index
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  get "/articles/new" do
    erb :new
  end

  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(
      title: params[:title],
      content: params[:content]
    )
    id = @article.id
    redirect "/articles/#{id}"
  end

  get "/articles/:id" do
    @article = Article.find(params[:id])
      erb :show
  end

  post "/articles" do
    article = Article.create(params)
    id = article.id
    redirect "/articles/#{id}"
  end


  delete "/articles/:id" do
    article = Article.find(params[:id])
    article.destroy

    redirect "/articles"
  end

end
