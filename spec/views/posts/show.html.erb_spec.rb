require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    @post = assign(:post, Post.create!(
      :title => "Title",
      :user => user
    ))
  end

  xit "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
