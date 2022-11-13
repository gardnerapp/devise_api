# frozen_string_literal: true

require 'test_helper'
# TODO add omniauth_controllers ??
class APIontrollersGeneratorTest < Rails::Generators::TestCase
  test Devise::Generators::APIControllersGenerator # Controller we are testing
  destination File.expand_path("../../tmp") # Where we expect our test files to be
  setup :prepare_destination # whipe out previous files from tmp directory

  @controller_names = %w[sessions registrations confirmations passwords unlocks]


  test "Assert no api controllers are created with no params" do
    capture(:stderr) { run_generator }
    # runs generator and captures errors; run_generator is usually passed with command line args
    @controller_names.each do |controller|
      assert_no_file "app/controllers/api/#{controller}_controller.rb"
    end
  end

  test "Assert All controllers are properly created with scoped params" do
    %w[users admins].each do |scope|
      run_generator scope
      assert_class_names scope
    end
  end

  test "assert specified controllers with scope" do
    run_generator %w(users -c sessions)
    assert_file "app/controllers/api/users/sessions_controller.rb"
    @controller_names.drop_while{|elem| elem == "sessions"}.each do |controller|
      assert_no_file "app/controllers/api/#{controller}_controller.rb"
    end
  end

  private

  # This method also exists within controllers_generators_test.rb but with some
  # minor differences, could add it to Rails::Generators::TestCase to keep code dry
  # if I add a private method to a module and include/extend that module into a class
  # will that method be available in the class as a private method
  def assert_class_names(scope, options = {})
    base_dir = "app/controllers/api#{scope.blank ? '' : ('/' + scope)}"
    scope_prefix = scope.blank? ? '' : (scope.camelize + '::')
    controllers = options[:controllers] || @controllers

    controllers.each do |c|
      # 2nd argument to assert_file is a regex for content within the file
      assert_file "#{base_dir}/#{c}_controller.rb", /#{scope_prefix + c.camelize}/
    end
  end

end
