require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'For the Post model' do
    before(:each) do
      @user = User.new(name: 'Tom', photo: 'image.png', bio: 'Teacher from Mexico', post_counter: 0)
      @post = Post.new(author: @user, title: 'Test', text: 'testing', likes_counter: 6, comments_counter: 1)
    end

    before { @post.save }

    it 'if there is title' do
      @post.title = true
      expect(@post).to be_valid
    end

    it 'if there is max 250 characters' do
      @post.title = 'Testing'
      expect(@post).to be_valid
    end

    it 'if likes counter is integer' do
      @post.likes_counter = 5
      expect(@post).to be_valid
    end

    it 'if likes counter greater than or equal to zero' do
      @post.likes_counter = -9
      expect(@post).to_not be_valid
    end

    it 'if comments counter greater than or equal to zero.' do
      @post.comments_counter = -5
      expect(@post).to_not be_valid
    end

    it 'if comments counter is integer' do
      @post.comments_counter = 8
      expect(@post).to be_valid
    end

    it 'recent_comments method should return the last five comments' do
      user = User.new

      post = described_class.create(title: 'Post One', text: 'This is the post one')

      post.comments = [
        Comment.new({ author: user, text: 'This is the comment one' }),
        Comment.new({ author: user, text: 'This is the comment two' }),
        Comment.new({ author: user, text: 'This is the comment three' }),
        Comment.new({ author: user, text: 'This is the comment four' }),
        Comment.new({ author: user, text: 'This is the comment five' }),
        Comment.new({ author: user, text: 'This is the comment six' })
      ]

      expect(post.recent_comments.size).to be(5)
      expect(post.recent_comments.pluck(:id)).to match_array(post.comments.last(5).pluck(:id))
    end
  end
end
