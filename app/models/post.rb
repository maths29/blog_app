class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'post_id', dependent: :destroy
  has_many :comments, foreign_key: 'post_id', dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_user_post_counter
  after_destroy :decrease_user_posts_counter

  def self.recent_comments(post)
    post.comments.order(created_at: :desc).limit(5)
  end

  def decrease_user_posts_counter
    author.decrement!(:posts_counter)
  end

  private

  def update_user_post_counter
    user.update(posts_counter: user.posts.count)
  end
end