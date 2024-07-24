# frozen_string_literal: true

require 'erubis'
require_relative 'file_model'

module Rulers
  class Controller
    include Rulers::Model
    attr_reader :env

    def initialize(env)
      @env = env
      @routing_params = {}
    end

    def self.action(act, rp = {})
      proc { |e| new(e).dispatch(act, rp) }
    end

    def dispatch(action, routing_params = {})
      @routing_params = routing_params
      text = send(action)
      r = get_response

      if r
        [r.status, r.headers, [r.body].flatten]
      else
        [200, { 'Content-Type' => 'text/html' },
         [text].flatten]
      end
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

    def response(text, status = 200, headers = {})
      raise 'Already responded' if @response

      a = [text].flatten
      @response = Rack::Response.new(a, status, headers)
    end

    def get_response
      @response
    end

    def render_response(*args)
      response(render(*args))
    end

    def params
      request.params.merge @routing_params
    end

    def render(view_name, locals = {})
      filename = File.join 'app', 'views', controller_name, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result locals.merge(env: env)
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore klass
    end
  end
end
