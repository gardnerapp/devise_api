# frozen_string_literal: true
# DeviseApiController: A Light Weight Version of DeviseController
class DeviseApiController < DeviseController

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

ActionController::Base.without_modules(EXCESS_MODS)


  # Basically this class needs to have methods for dynamically dealing with
  # resources

  # What are all of the methods that my controllers need
  # 1) rendering resource as JSON, XML
  # 2) rendering error messages from a resource
  # 3) linking into already existing devise function





end
