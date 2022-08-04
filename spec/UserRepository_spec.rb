require 'users_repository'

def reset_students_table
  seed_sql = File.read('spec/seeds_SocialNetwork.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe UserRepository do
  before(:each) do 
    reset_students_table
  end
  it "retruns all items in database to model class 'user'" do
    repo = UserRepository.new
    users = repo.all

    expect(users.length).to eq  2
    expect(users[0].id).to eq   "1"
    expect(users[0].email).to eq    'email1'
    expect(users[0].username).to eq    'user1'
    expect(users[1].id).to eq    "2"
    expect(users[1].email).to eq    'email2'
    expect(users[1].username).to eq   'user2'
  end 
  it 'Get a single student with find()' do
    repo = UserRepository.new

    user = repo.find(1)

    expect(user[0].id).to eq   "1"
    expect(user[0].email).to eq 'email1'
    expect(user[0].username).to eq   'user1'
  end 
  it 'add in a single user'  do
    repo = UserRepository.new
    user = User.new
    user.username = 'username3'
    user.email = 'email3'
    repo.create(user)
    users = repo.all

    expect(users.length).to eq  3
    expect(users[2].id).to eq   "3"
    expect(users[2].email).to eq    'email3'
    expect(users[2].username).to eq    'username3'
  end 
  it 'update a user' do 
    repo = UserRepository.new
    users = repo.all
    user = users[0]
    user.email = 'new_email'
    repo.update(user, 'email')
    user_new_list = repo.all

    expect(user_new_list.length).to eq  2
    expect(user_new_list[1].id).to eq   "1"
    expect(user_new_list[1].email).to eq    'new_email'
    expect(user_new_list[1].username).to eq    'user1'
  end 
  it 'delete a user' do 
    repo = UserRepository.new
    users = repo.all
    user = users[0]
    repo.delete(user)
    users = repo.all

    expect(users.length).to eq  1
    expect(users[0].id).to eq   "2"
    expect(users[0].email).to eq    'email2'
    expect(users[0].username).to eq    'user2'
  end 


end