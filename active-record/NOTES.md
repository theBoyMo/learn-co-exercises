## Active Record

Active Record represents the Model layer in the MVC pattern - responsible for implementing business data and logic. Active Record is the implementation of a design pattern which facilitates the creation, use and storage of business objects. It is itself an ORM system, enabling those object classes and attributes to be mapped to database tables and columns respectively. By following the adopted conventions, there is very little SQL code that need be written.

### Implementing Active Record

Active Record is a Ruby gem, so include it in your Gemfile. In the config/environment.rb add a connection to the database

```ruby
  conn = ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'db/students.sqlite'
    )}
```

In your class file, create your sql table:

```ruby
  sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT
  )
  SQL
  ActiveRecord::Base.conn.execute(sql)
```

To make use of ActiveRecord's built in ORM methods, ensure that your ruby class inherit from ActiveRecord::Base class.

```ruby
  class Student < ActiveRecord::Base
  end
```

#### Available Methods

```ruby
  # retrieve all column names
  Student.column_names #=> [:id, :name]

  # create a new student record in the database
  # "INSERT INTO students (name) VALUES (John)";
  student1 = Student.create(name: 'John') #=> returns instance of class

  # to create a record if it does not already exist
  student2 =  Student.find_or_create_by({name: 'John'}) #=> returns instance of class
  student1.id == student2.id

  # retrieve a record by id
  # "SELECT * FROM students WHERE id = 1";
  Student.find(1) #=> returns instance of class

  # retrieve a record by any of it's attributes, e.g. name
  # "SELECT * FROM students WHERE name = 'John' LIMIT 1";
  Student.find_by(name: 'John') #=> returns instance of class

  # there's also, .find_by_[attr_name], e.g
  Student.find_by_name('John') #=> returns instance of class
  Student.find_by_id(1) #=> returns instance of class

  # getters/setters of an instance
  # there's no need to define attr_accessors
  student.name #=> 'John'
  student.name = 'Peter'
  student.name #=> 'Peter'

  # save changes to the database
  student.save

  # to update and save a record in one step
  student.update({name: 'Simon'})
  student.name #=> 'Simon'
```




### References
1. [Active Record Basics](http://guides.rubyonrails.org/active_record_basics.html)
2. [Querying Active Record](http://guides.rubyonrails.org/active_record_querying.html)