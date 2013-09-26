module UbigeoRails
  extend self
  
  attr_accessor :table_name
  attr_accessor :db_connection_proc
  
  def config
    dsl_config = DSLConfig.new
    yield dsl_config
  end
  
  class DSLConfig
    def table_name
      UbigeoRails.table_name = table_name
    end
    
    def db_connection(&proc)
      UbigeoRails.db_connection_proc = proc
    end
  end
end