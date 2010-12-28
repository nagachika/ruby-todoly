
class Todoly
  class Filter
    def self.list(rest_if)
      rest_if.filters.map do |f|
        self.new(rest_if, f)
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
      @rest_if.items_of_filter(@id).map do |item|
        Task.new(@rest_if, item)
      end
    end
  end
end
