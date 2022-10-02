# frosen_string_literal: true

require 'rails/generators/base'

module Devise
  module Generators
    class ApiControllersGenerator < Rails::Generators::Base
      # Rails::Generators::Base includes Thor::Actions, Rails::Generators::Actions
      CONTROLLERS = %w[registrations sessions].freeze

      source_root File.expand_path("../../../templates/api_controllers", __FILE__)
    end
  end
end
