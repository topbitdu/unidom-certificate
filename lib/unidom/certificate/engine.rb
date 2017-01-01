module Unidom
  module Certificate

    class Engine < ::Rails::Engine

      include Unidom::Common::EngineExtension

      isolate_namespace ::Unidom::Certificate

      enable_initializer enum_enabled: false, migration_enabled: true

    end

  end
end
