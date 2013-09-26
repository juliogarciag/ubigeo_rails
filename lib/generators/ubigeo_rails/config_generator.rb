module UbigeoRails
  module Generators
    class ConfigGenerator < ::Rails::Generators::Base
      def create_config_file
        create_file "config/ubigeo_rails.rb", config_file_content
      end
      
      private
      
      def config_file_content
<<CODE
UbigeoRails.config do |config|
  # config.table_name 'ubigeo'
  # config.db_connection { Rails.env }
end
CODE
      end
    end
  end
end