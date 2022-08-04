require_relative 'user'

class UserRepository

  # Selecting all records
  # No arguments
  def all
    output = []
    sql = 'SELECT * FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each{|record|
      user = User.new
      user.id = record['id']
      user.username = record['username']
      user.email = record['email']
      output << user
    }
    return output
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    output = []
    sql = 'SELECT * FROM users WHERE id = $1'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    result_set.each{|record|
      user = User.new
      user.id = record['id']
      user.username = record['username']
      user.email = record['email']
      output << user
    }
    return output
  end

   def create(user)
    output = []
    sql = 'INSERT INTO users (username, email) VALUES($1, $2);'
    params = []
    params << user.username << user.email
    DatabaseConnection.exec_params(sql,params)
   end

   def update(user, update_field)
    sql = updater_string(update_field)
    params = []
    case update_field 
    when "email"
      params << user.email
    when "id"
      params << user.id
    when "username"
      params << user.username
    end 
    params << user.id
    DatabaseConnection.exec_params(sql, params)
   end

   def updater_string(update_field)
    return "UPDATE users SET #{update_field} = $1 WHERE id = $2;"
   end

  def delete(user)
    sql = 'DELETE FROM users WHERE id = $1;'
    params = [user.id]
    DatabaseConnection.exec_params(sql, params)
  end
end