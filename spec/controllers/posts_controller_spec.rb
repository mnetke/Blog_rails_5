# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
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
    { 'title' => 'first post',
      'image' => file }
  end

  let(:invalid_attributes) { { 'title' => ' ' } }
  let(:update_attributes) { { 'title' => 'updated post' } }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: test_post.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: test_post.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Post' do
        post :create, params: { post: valid_attributes }
        expect(Post.count).to eq(1)
      end

      it 'redirects to the created post' do
        post :create, params: { post: valid_attributes }
        expect(response).to redirect_to(Post.last)
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        post :create, params: { post: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested post' do
        put :update, params: { id: test_post.id, post: update_attributes }
        test_post.reload
        expect(test_post.title).to eq(update_attributes['title'])
      end

      it 'redirects to the post' do
        put :update, params: { id: test_post.id, post: valid_attributes }
        expect(response).to redirect_to(test_post)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: test_post.id, post: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested post' do
      delete :destroy, params: { id: test_post.id }
      expect(Post.count).to eq(0)
    end

    it 'redirects to the posts list' do
      delete :destroy, params: { id: test_post.id }
      expect(response).to redirect_to(posts_url)
    end
  end
end
