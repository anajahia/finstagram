helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end

require "pry"
require "sinatra"
require "slim"
require "require_all"
require_all("app/routes/*.rb")

get '/' do
   @posts = Post.order(created_at: :desc)
    @current_user = if session[:user_id]
            User.find(session[:user_id])
    else
        nil
    end
    slim(:index)
end


get '/signup' do
    @user = User.new
    erb(:signup)
end


get '/users' do
    @users = User.all
    erb(:users)
end

post '/signup' do
  begin
    @user = User.new(params.slice(:email, :avatar_url, :username, :password))
    
    # if user validations pass and user is saved
    if @user.save
        redirect to('/login')
    else
        erb(:signup)
    end
  rescue
    binding.pry
  end
end

get '/login' do
    erb(:login)
end
 
 
post '/login' do
    username = params[:username]
    password = params[:password]
    
    user = User.find_by(username: username)
    
    if user && user.password == password
        session[:user_id] = user.id
        redirect to ('/')
    else
        @error_message = "Login failed."
        erb(:login)
    end
end

get '/logout' do
    session[:user_id] = nil
    redirect to('/')
end


get '/posts/new' do
    erb(:"posts/new")
end

post '/posts' do
    photo_url = params[:photo_url]
    
    @post = Post.new({ photo_url: photo_url, user_id: @current_user.id })
    
    if @post.save  
        redirect(to('/'))
    else
        @post.errors.full_messgae.inspect
    end
end
