class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author

  after_save :update_post_like_counter

  private

  def update_post_like_counter
    post.update(likes_counter: post.likes.count)
  end
end