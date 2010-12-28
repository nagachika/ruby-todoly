
require "todoly/rest_interface"
require "todoly/project"
require "todoly/filter"
require "todoly/task"

class Todoly
  def initialize(opt={})
    @rest_if = RestInterface.new(opt)
    @projects = nil
    @filters = nil
    @tasks = nil
  end

  def projects
    @projects ||= Project.list(@rest_if)
  end

  def filters
    @filters ||= Filter.list(@rest_if)
  end

  def tasks
    @tasks ||= Task.list(@rest_if)
  end

  def new_task(str, project = nil)
    obj = {}
    if project
      obj["ProjectId"] = project.id
    end
    t = Task.create(@rest_if, str, obj)
    @tasks << t if @tasks
    t
  end
end
