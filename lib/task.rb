class Task
  attr_reader(:description, :list_id, :due_date)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @list_id = attributes.fetch(:list_id)
    @due_date = attributes.fetch(:due_date)
  end

  define_singleton_method(:all) do
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()# The information comes out of the database as a string, and needs to be converted to an integer
      due_date = task.fetch("due_date")
      tasks.push(Task.new({:description => description, :list_id => list_id, :due_date => due_date}))
    end
    tasks
  end

  define_method(:save) do
    DB.exec("INSERT INTO tasks (description, list_id, due_date) VALUES ('#{@description}', #{@list_id}, '#{@due_date}');")
  end

  define_singleton_method(:sort) do
    sorted_tasks = DB.exec("SELECT * FROM tasks ORDER BY due_date;")
    tasks = []
    sorted_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      due_date = task.fetch("due_date")
      tasks.push(Task.new({:description => description, :list_id => list_id, :due_date => due_date}))
    end
    tasks
  end

  define_method(:==) do |another_task|
    self.description().==(another_task.description()).&(self.due_date().==(another_task.due_date())).&(self.list_id().==(another_task.list_id()))
  end
end
