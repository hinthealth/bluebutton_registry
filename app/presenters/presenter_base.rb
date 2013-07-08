module Presenter
  class Base
    def initialize(obj)
      @object = obj
    end
    def as_json(options = {})
      @object.as_json(options)
    end
  end
end