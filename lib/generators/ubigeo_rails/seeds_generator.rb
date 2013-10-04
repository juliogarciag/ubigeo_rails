module UbigeoRails
  module Generators
    class SeedsGenerator < ::Rails::Generators::Base
      def add_to_seeds
        inject_into_file('db/seeds.rb') do <<-CODE..gsub /^\s+/, ""
          UbigeoRails.seed_db!
        CODE
        end
      end
    end
  end
end