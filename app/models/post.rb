class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments
    
    def humanized_time_ago
        "61 minutes ago"
    end
end