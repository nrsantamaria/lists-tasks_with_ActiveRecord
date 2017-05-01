require'spec_helper'
require'pry'
describe(Task) do

  describe('.all') do
    it('is empty at first') do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2011-04-01'})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe('#description') do
    it('lets you give it a description') do
      test_task = Task.new({:description => "wash the lion", :list_id => 1, :due_date => '2011-04-01'})
      expect(test_task.description()).to(eq("wash the lion"))
    end
  end

  describe('.sort') do
    it('sorts the tasks by due date') do
      task1 = Task.new({:description => "learn SQL", :due_date => '2017-04-01', :list_id => 1})
      task1.save()
      task2 = Task.new({:description => "learn ruby", :due_date => '2014-05-01', :list_id => 1})
      task2.save()
      expect(Task.sort()).to(eq([task2, task1]))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2011-04-01'})
      task2 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2011-04-01'})
      expect(task1).to(eq(task2))
    end
  end
end
