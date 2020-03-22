require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    assign(:posts, [
      Post.create!(
        :title => "Title",
        :user => user
      ),
      Post.create!(
        :title => "Title",
        :user => user
       )
    ])
  end

  xit "renders a list of posts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
