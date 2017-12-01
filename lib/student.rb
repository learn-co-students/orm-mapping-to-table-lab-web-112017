class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_reader :id, :name, :grade

  def initialize(name,grade)
    @name = name
    @grade = grade
    @id = nil
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students" #IF EXISTS
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?,?)
    SQL
    DB[:conn].execute(sql,self.name,self.grade)
  end

  def self.create(attr_hash)
    #attr_hash.each |attr,val|
    new_stud = Student.new(attr_hash[:name],attr_hash[:grade])
    new_stud.save
    #new_stud.id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    new_stud
  end

  def id
    DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end 


end
