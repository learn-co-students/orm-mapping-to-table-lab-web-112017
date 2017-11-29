class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name = "", grade = "", id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    DB[:conn].execute(<<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT);
      SQL
    )
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end

  def save
    DB[:conn].execute("INSERT INTO students(name,grade) VALUES ('#{self.name}', '#{self.grade}');")
    @id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC;")[0][0]
  end

  def self.create(args)
    a = self.new()
    args.each{|k,v| a.send("#{k}=",v)}
    a.save
    a
  end

end
