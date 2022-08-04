require "user"

RSpec.describe User do 
  it "user returns correct values after input" do
    user = User.new
    user.id = 1
    user.email = 'email'
    user.username = 'username'
    expect(user.id).to eq 1
    expect(user.email).to eq 'email'
    expect(user.username).to eq 'username'
  end 
end