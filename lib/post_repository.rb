require_relative 'post'

class PostRepository

  # Selecting all records
  # No arguments
  def all
  output = []
  sql = 'SELECT * FROM posts;'
  result_set = DatabaseConnection.exec_params(sql, [])
  result_set.each{|record|
    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.views = record['views']
    post.user_id = record['user_id']
    output << post
  }
  return output
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    output = []
    sql = 'SELECT * FROM posts WHERE id = $1'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    result_set.each{|record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.user_id = record['user_id']
      output << post
    }
    return output
  end

  def create(post)
    output = []
    sql = 'INSERT INTO posts (title, content, user_id, views) VALUES($1, $2, $3, $4);'
    params = []
    params << post.title << post.content << post.user_id << post.views
    DatabaseConnection.exec_params(sql,params)
  end

   def update(post, update_field)
    sql = updater_string(update_field)
    params = []
    case update_field 
    when "title"
      params << post.title
    when "id"
      params << post.id
    when "content"
      params << post.content
    when "views"
      params << post.views
    when "user_id"
      params << post.user_id
    end 
    params << post.id
    DatabaseConnection.exec_params(sql, params)
   end

   def updater_string(update_field)
    return "UPDATE posts SET #{update_field} = $1 WHERE id = $2;"
   end

   def delete(post)
     sql = 'DELETE FROM users WHERE id = $1;'
     params = [post.id]
     DatabaseConnection.exec_params(sql, params)
   end
end