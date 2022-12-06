require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'For the Post model' do
    before(:each) do
      @user = User.new(name: 'Tom', photo: 'image.png', bio: 'Teacher from Mexico', post_counter: 0)
      @post = Post.new(author: @user, title: 'Test', text: 'testing', likes_counter: 6, comments_counter: 1)
    end

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

    it 'if comments counter is integer' do
      @post.comments_counter = 8
      expect(@post).to be_valid
    end
  end
end
