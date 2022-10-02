# frozen_string_literal: true
# DeviseApiController: A Light Weight Version of DeviseController

class DeviseAPIController < DeviseController

  # Modules not normally included in ActionController
  API_MODULES = [ActionController::ApiRendering, ActionController::BasicImplicitRender].each {|mod| include mod}

  # Modules that are in ActionController::Base but not ActionController::API
  # Upon Further testing some of these modules &/or their methods may need to be included
  # in order to prevent no_method errors from DeviseController
  EXCESS_MODS = [
    AbstractController::Translation,
    AbstractController::AssetPaths,
    ActionController::Helpers,
    ActionView::Layouts,
    ActionController::Rendering,
    ActionController::EtagWithTemplateDigest,
    ActionController::EtagWithFlash,
    ActionController::Caching,
    ActionController::MimeResponds,
    ActionController::ImplicitRender,
    ActionController::ParameterEncoding,
    ActionController::Cookies,
    ActionController::Flash,
    ActionController::FormBuilder,
    ActionController::RequestForgeryProtection,
    ActionController::ContentSecurityPolicy,
    ActionController::PermissionsPolicy,
    ActionController::Streaming,
    ActionController::HttpAuthentication::Basic::ControllerMethods,
    ActionController::HttpAuthentication::Digest::ControllerMethods,
    ActionController::HttpAuthentication::Token::ControllerMethods
  ]

  # Remove excess modules
  ActionController::Base.without_modules(EXCESS_MODS)

  # A list of resource attributes that should not be exposed to the API Client
  DANGEROUS_ATTRS = %i[
    reset_password_token
    encrypted_password
    confirmation_token
    unlock_token
  ]

  # returns the attributes of a resource as a json object
  def resource_to_json
    # compact removes nil attributes
    resource.as_json(except: DANGEROUS_ATTRS).compact
  end


  def errors_to_json
  end 


  # Basically this class needs to have methods for dynamically dealing with
  # resources

  # What are all of the methods that my controllers need
  # 1) rendering resource as JSON
  # 2) rendering error messages from a resource in json
  # 3) linking into already existing devise function





end
