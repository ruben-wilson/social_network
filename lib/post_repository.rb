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
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end