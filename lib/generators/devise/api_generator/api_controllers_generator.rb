# frosen_string_literal: true

require 'rails/generators/base'

module Devise
  module Generators
    class ApiControllersGenerator < Rails::Generators::Base
      # Rails::Generators::Base includes Thor::Actions, Rails::Generators::Actions
      CONTROLLERS = %w[registrations sessions].freeze

      # description of generator
      desc <<-DESC.strip_heredoc
        Create inherited Devise Controllers in your app/controllers/ folder.
        In order to add the controller(s) to an api subfolder within controllers, please
        prefix the scope with the folder name(s).

        Use -c to specify which controller you want to generate.
        If you do not specify a controller, all API controllers will be generated.
        For example:

          rails generate devise:api_controllers api/v1/users -c=registrations

        This will create a controller class at app/controllers/api/v1/users/registrations_controller.rb like this:

          class Users::Api::RegistrationsController < Devise::ApiRegistrationsController
            content...
          end
      DESC

      # source_root == where my templates are located
      # File.expand_path turns relative path into an absolute one
      source_root File.expand_path("../../../templates/api_controllers", __FILE__)

      # adds required arguments & sub arguments
      argument :scope, required: true,
        desc: "The scope to create controllers in, e.g. users, api/users /api/v1/users"
      class_option :controllers, aliases: "-c", type: :array,
        desc: "Select and specific controllers to generate (#{CONTROLLERS.join(', ')})"

      def create_api_controllers
        @scope_prefix = scope.blank ? '' : (scope.camelize + '::')
        controllers = options[:controllers] || CONTROLLERS
        controllers.each do |name|
          template "#{name}_controller.rb",
                    "app/controllers#{scope}/#{name}_controller.rb"
      end
    end
  end
end
