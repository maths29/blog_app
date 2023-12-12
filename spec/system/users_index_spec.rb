require 'rails_helper'

RSpec.describe 'Users#index', type: :system do
  before(:each) do
    # Create users and associated posts for testing
    @lilly = User.create!(name: 'Lilly', photo: 'https://portraits.ai', bio: '', posts_counter: 0)
    Post.create!(title: 'First Post', text: 'This is my first post', author: @lilly, comments_counter: 0, likes_counter: 0)
    @tom = User.create!(name: 'Tom', photo: 'https://portraits.ai', bio: '', posts_counter: 0)
    @users = User.all
  end 

  # I can see the username of all other users.
  it 'displays the names of all users' do
    @lilly.destroy_with_associations
    visit '/users'
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end
end
