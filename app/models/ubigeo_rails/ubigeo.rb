module UbigeoRails
  class Ubigeo < ActiveRecord::Base
    # TODO: Add Generator for initializer
    # TODO: Configurable
    self.table_name = 'ubigeo_ubigeo'
    # TODO: Configurable
    establish_connection "general_#{Rails.env}"
    # TODO: Generator If migration is needed: rails g ubigeo_rails:migration
    # TODO: Generator if seed is needed: rails g ubigeo_rails:seeds

    belongs_to :parent, class_name: "UbigeoRails::Ubigeo"
    
    def has_department?
      digits >= 2 && digits <= 6
    end
    
    def has_province?
      digits >= 4 && digits <= 6
    end
    
    def has_district?
      digits == 6
    end
    
    def department_part
      id.to_s[0..1]
    end
    
    def province_part
      id.to_s[2..3]
    end
    
    def district_part
      id.to_s[4..5]
    end
    
    def self.with_parent(parent_id)
      where parent_id: parent_id
    end
    
    private
    
    def digits
      id ? id.to_s.size : 0
    end
  end
end