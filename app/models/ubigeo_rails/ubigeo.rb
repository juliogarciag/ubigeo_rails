module UbigeoRails
  class Ubigeo < ActiveRecord::Base
    if UbigeoRails.table_name.present?
      self.table_name = UbigeoRails.table_name
    end
    
    connection_name = if UbigeoRails.db_connection_proc.present?
      UbigeoRails.db_connection_proc.call
    else
      Rails.env
    end
    
    establish_connection connection_name
    
    # TODO: Generator If migration is needed: rails g ubigeo_rails:migration
    # id, name and parent_id, timestamps
    # TODO: Generator if seed is needed: rails g ubigeo_rails:seeds

    belongs_to :parent, class_name: "UbigeoRails::Ubigeo"
    
    def has_department?
      digits >= 1 && digits <= 6
    end
    
    def has_province?
      digits >= 3 && digits <= 6
    end
    
    def has_district?
      digits >= 5 && digits <= 6
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