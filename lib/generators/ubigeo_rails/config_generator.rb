module UbigeoRails
  module Generators
    class ConfigGenerator < ::Rails::Generators::Base
      def create_config_file
        create_file "config/ubigeo_rails.rb", "Hola :D"
      end
    end
  end
end