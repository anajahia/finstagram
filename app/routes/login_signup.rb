get '/signup' do
  @user = User.new
  erb(:signup)
end

post '/signup' do
  @user = User.new(params.slice(:email, :avatar_url, :username, :password))
  
  # if user validations pass and user is saved
  if @user.save
      redirect to('/login')
  else
      erb(:signup)
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


get '/users' do
  @users = User.all
  erb(:users)
end

