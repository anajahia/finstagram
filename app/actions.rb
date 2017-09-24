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
