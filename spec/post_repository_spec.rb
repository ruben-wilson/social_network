require 'post_repository'

def reset_students_table
  seed_sql = File.read('spec/seeds_SocialNetwork.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do 
    reset_students_table
  end
  it " Get all students" do 
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq  2
    expect(posts[0].id).to eq  "1"
    expect(posts[0].title).to eq  'title1'
    expect(posts[0].content).to eq  'content1'
    expect(posts[0].views).to eq  '5'
    expect(posts[0].user_id).to eq  '1'
    expect(posts[1].id).to eq  "2"
    expect(posts[1].title).to eq  'title2'
    expect(posts[1].content).to eq  'content2'
    expect(posts[1].views).to eq  '3'
    expect(posts[1].user_id).to eq  '2'
  end 
  it "gets a single student" do 
    repo = PostRepository.new
    post = repo.find(1)

    expect(post.length).to eq 1
    expect(post[0].id).to eq "1"
    expect(post[0].title).to eq 'title1'
    expect(post[0].content).to eq 'content1'
    expect(post[0].views).to eq '5'
    expect(post[0].user_id).to eq '1'
  end 
  it "add a user object to db" do
    repo = PostRepository.new
    post = Post.new
    post.title = 'new_title'
    post.content = 'new_content'
    post.user_id = 1
    post.views = 6
    repo.create(post)
    posts = repo.all


    expect(posts.length).to eq  3
    expect(posts[2].title).to eq  'new_title'
    expect(posts[2].content).to eq  'new_content'
    expect(posts[2].user_id).to eq  "1"
    expect(posts[2].views).to eq  "6"
  end 
   it "update a user" do
    repo = PostRepository.new
    posts = repo.all
    post = posts[0]
    post.content = 'new_content'

    repo.update(post, 'content')

    posts = repo.all

    expect(posts.length).to eq  2
    expect(posts[1].id).to eq   "1"
    expect(posts[1].content).to eq    'new_content'
    expect(posts[1].views).to eq   "5"
    expect(posts[1].user_id).to eq '1'
   end
   it "delete a user" do
    repo = PostRepository.new
    posts = repo.all
    post = posts[0]
    repo.delete(post)
    posts = repo.all

    expect(posts.length).to eq  1
    expect(posts[0].title).to eq   "title2"
    expect(posts[0].content).to eq    'content2'
    expect(posts[0].user_id).to eq    '2'
    expect(posts[0].views).to eq    '3'
    expect(posts[0].id).to eq    '2'
   end 



  # (your tests will go here).
end