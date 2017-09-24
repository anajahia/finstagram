
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
