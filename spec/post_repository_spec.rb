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
    post = repo.search(1)

    expect(post.length).to eq 1
    expect(post[0].id).to eq "1"
    expect(post[0].title).to eq 'title1'
    expect(post[0].contents).to eq 'content1'
    expect(post[0].views).to eq '5'
    expect(post[0].user_id).to eq '1'
  end 


  # (your tests will go here).
end