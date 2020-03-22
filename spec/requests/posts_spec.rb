
# require 'rails_helper'

# feature 'Reading the Blog' do
  
#   background do   
#     Post.destroy_all
#     @post = Post.create(title: 'Awesome Blog Post')
#     Post.create(title: 'Another Awesome Post')
#     @user = User.create(email: 'user@example.com', password: '123456', password_confirmation: '123456')
#     sign_in @user
#   end

#   scenario 'Reading the blog index' do
#     visit root_path

#     expect(page).to have_content 'Awesome Blog Post'
#     expect(page).to have_content 'Another Awesome Post'
#   end

#   scenario 'Reading an individual blog' do
#     visit root_path
#     click_link 'Awesome Blog Post'

#     expect(current_path).to eq post_path(@post)
#   end
# end