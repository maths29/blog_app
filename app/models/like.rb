class like < ApplicationRecord
    belongs_to :user
    belongs_to :posts
    
    after_save :update_likes_counter
    
end