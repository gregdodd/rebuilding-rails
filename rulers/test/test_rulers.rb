# frozen_string_literal: true

require 'test_helper'

class TestRulers < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Rulers::VERSION
  end
end
