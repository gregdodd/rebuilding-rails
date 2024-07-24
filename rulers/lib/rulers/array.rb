# frozen_string_literal: true

module Rulers
  class Array
    def deeply_empty?
      empty? || all?(&:empty?)
    end
  end
end
