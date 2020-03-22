require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  login_user

  let(:file) { fixture_file_upload('files/test.jpg', 'image/jpg') }
  let(:test_post) do
    ::Post.create!(title: 'first post',
                   image: file,
                   user: warden.user)
  end

  let(:valid_attributes) do
    { 'name' => 'first comment',
      'comment' => 'new commment' }
  end

    describe 'COMMENT #create' do
        context 'with valid params' do
          it 'creates a new Commennt' do
            post :create, params: {post_id:test_post.id, comment: valid_attributes }
            expect(Comment.count).to eq(1)
          end
    
          it 'redirects to the created post' do
            post :create, params: {post_id:test_post.id, comment: valid_attributes }
            expect(response).to redirect_to(Post.first)
          end
        end
    end
end
