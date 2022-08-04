require "post"

RSpec.describe Post do 
  it "posts returns correct values after input" do
    post = Post.new
    post.id = 1
    post.title = 'title'
    post.content = 'content'
    post.views = 6
    post.user_id = 2
    expect(post.id).to eq 1
    expect(post.title).to eq 'title'
    expect(post.content).to eq 'content'
    expect(post.views).to eq 6
    expect(post.user_id).to eq 2
  end 
end
