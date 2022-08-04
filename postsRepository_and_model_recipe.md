# posts Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, user_id) VALUES ('title1', 'content1', 5 , 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('title2', 'content2', 3 , 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network_test < seeds_posts.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class post
end

# Repository class
# (in lib/student_repository.rb)
class PostsRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :contents, :views, :user_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class PostsRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
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
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all students

repo = StudentRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # =>  "1"
posts[0].title # =>  'title1'
posts[0].contents # =>  'content1'
posts[0].views # =>  '5'
posts[0].user_id # =>  '1'

posts[1].id # =>  "2"
posts[1].title # =>  'title2'
posts[1].contents # =>  'content2'
posts[1].views # =>  '3'
posts[1].user_id # =>  '2'

# 2
# Get a single student

repo = StudentRepository.new

posts = repo.all

post = posts.search(1)

post.length # =>  1

post[0].id # =>  "1"
post[0].title # =>  'title1'
post[0].contents # =>  'content1'
post[0].views # =>  '5'
post[0].user_id # =>  '1'

# 3
# add in a single user 

repo = postRepository.new
post =post.new
post.username = 'username3'
post.email = 'email3'
repo.createpost)
post = repo.all


post.length  3
post[2].id   "3"
post[2].email    'email3'
post[2].username    'user2'

# 4
# update a user 

repo = postRepository.new
post = repo.all

user = post[0]

user.email = 'new_email'

repo.update(user, 'email')

post = repo.all

post.length  2
post[0].id   "1"
post[0].email    'new_email'
post[0].username    'user1'

# 5
# delete a user 

repo = postRepository.new
post = repo.all
user = post[0]
repo.delete(user)

post = repo.all

post.length  1
post[0].id   "2"
post[0].email    'email2'
post[0].username    'user2'





# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

