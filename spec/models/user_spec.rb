require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations for User model' do
    before(:each) do
      @user = User.new(name: 'Tom', bio: 'Teacher from Mexico', post_counter: 0)
    end

    before { @user.save }

    it 'if there is name' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'PostCounter must be greater than or equal to zero' do
      @user.post_counter = -1
      expect(@user).to_not be_valid
    end

    it 'PostCounter must be greater than or equal to zero' do
      @user.post_counter = 5
      expect(@user).to be_valid
    end

    it 'Recent Posts method should show 5 posts' do
      user = described_class.create(name: 'Neeraj', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                  bio: 'Teacher from India.')

      user.posts = [
        Post.new({ title: 'Post One', text: 'This is the post one' }),
        Post.new({ title: 'Post Two', text: 'This is the post two' }),
        Post.new({ title: 'Post Three', text: 'This is the post three' }),
        Post.new({ title: 'Post Four', text: 'This is the post four' }),
        Post.new({ title: 'Post Five', text: 'This is the post five' })
      ]

      expect(user.recent_posts.size).to be(5)
      expect(user.recent_posts.pluck(:id)).to match_array(user.posts.last(5).pluck(:id))
    end
  end
end

