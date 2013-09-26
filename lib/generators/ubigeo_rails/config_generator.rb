module UbigeoRails
  class ConfigGenerator << Rails::Generators::Base
    def create_initializer_file
      create_file "config/ubigeo_rails.rb", <<CODE
        # Here is a couple of code
      CODE
    end
  end
end