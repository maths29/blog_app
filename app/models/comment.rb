class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :increment_post_comments_counter

  private

  def increment_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
