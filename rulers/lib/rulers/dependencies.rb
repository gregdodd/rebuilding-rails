# frozen_string_literal: true

module Rulers
  class Object
    def self.const_missing(c)
      require Rulers.to_underscore(c.to_s)
      Object.const_get(c)
    end
  end
end
