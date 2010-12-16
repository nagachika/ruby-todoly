
class Todoly
  class Task
    def self.list(rest_if)
      rest_if.items.map do |item|
        self.new(rest_if, item)
      end
    end

    def self.create(rest_if, name, obj={})
      obj["Content"] = name
      Task.new(rest_if, obj).save
    end

    def initialize(rest_if, obj)
      @rest_if = rest_if
      set_obj(obj)
    end

    def set_obj(obj)
      @raw = obj
      @id = obj["Id"]
      @name = obj["Content"]
    end

    attr_reader :raw, :id, :name

    def to_s
      @name
    end

    def name=(new_name)
      @name = @raw["Content"] = new_name
      save
      new_name
    end

    def check
      @raw["Checked"] = true
      save
    end

    def save
      if @id
        @rest_if.update_item_by_id(@id, @raw)
      else
        set_obj @rest_if.create_item(@raw)
      end
      self
    end
  end
end
