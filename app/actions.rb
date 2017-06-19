get '/' do
   @posts = Post.order(created_at: :desc) 
    erb(:index)
end

get '/signup' do    # if a user navigates to the path "/signup",
    erb(:signup)    # render "app/views/signup.erb"
end

post '/signup' do
    @user = User.new(params)
    @user.save
    erb(:welcome)
end