# frozen_string_literal: true

require_relative 'rulers/version'
require_relative 'rulers/array'
require_relative 'rulers/routing'
require_relative 'rulers/util'
require_relative 'rulers/dependencies'
require_relative 'rulers/controller'
require_relative 'rulers/file_model'

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404,
                { 'Content-Type' => 'text/html' }, []]
      end

      rack_app = get_rack_app(env)
      rack_app.call(env)
    end
  end

  def self.framework_root
    __dir__
  end
end
