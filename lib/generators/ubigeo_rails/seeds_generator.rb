module UbigeoRails
  module Generators
    class SeedsGenerator < ::Rails::Generators::Base
      def add_to_seeds
        inject_into_file('db/seeds.rb', after: '') do
          "UbigeoRails.seed_db!"
        end
      end
    end
  end
end