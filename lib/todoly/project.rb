
require "todoly/task"

class Todoly
  class Project

    def self.list(rest_if)
      rest_if.projects.map do |obj|
        self.new(rest_if, obj)
      end
    end

    def initialize(rest_if, obj)
      @rest_if = rest_if
      @raw = obj
      @id = obj["Id"]
      @name = obj["Content"]
    end

    attr_reader :raw, :id, :name

    def [](key)
      @raw[key]
    end

    def tasks
      @rest_if.items_of_project(@id).map do |item|
        Task.new(@rest_if, item)
      end
    end

    def done_tasks
      @rest_if.done_items_of_project(@id).map do |item|
        Task.new(@rest_if, item)
      end
    end
  end
end
