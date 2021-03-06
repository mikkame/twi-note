# frozen_string_literal: true

require "application_system_test_case"

class DisclaimersTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
  end

  test "show disclaimers" do
    visit disclaimers_path
    assert_selector "h1", text: "免責事項"
  end
end
