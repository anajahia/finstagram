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
