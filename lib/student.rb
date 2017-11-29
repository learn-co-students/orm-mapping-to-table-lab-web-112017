class Student
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id= nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
      SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
      SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?);
    SQL
    DB[:conn].execute(sql, @name, @grade)

    @id = DB[:conn].execute("SELECT id from students WHERE name = ? AND grade = ?", @name, @grade).first.first
  end

  def self.create(hash)
    student = Student.new(hash[:name], hash[:grade])
    student.save
    student
  end
end
