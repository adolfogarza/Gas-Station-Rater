require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)

module GasolinaSegura
  class Application < Rails::Application
    I18n.default_locale = :es
  end
end
