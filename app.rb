require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post #무조건 대문자, 중요
  include DataMapper::Resource
  property :id, String
  property :title, Text
  property :content, Text #text와 비슷, text가 더 많은 글자를 저장할 수 있다.
  #property :created_at, DateTime
  
end

DataMapper.finalize
Post.auto_upgrade!

get '/' do
    @post = Post.all
    erb :index #index로 렌더링
end

get '/create' do
    @title = params[:title]
    @content = params[:content]
    
    Post.create(
        title: @title,
        content: @content
        )
    redirect '/'
end
