## Instalación

# Asunciones

- Usas Formtastic
- Tienes ya una tabla de ubigeo.

# Instalación

- Agrega la gema al Gemfile
- Instala la gema (se agregará una ruta y un inicializador)

      rails g ubigeo_rails:install

# Configuración

- Edita el inicializador (en app/config/initializers/ubigeo_rails.rb) con datos como los siguientes:

      UbigeoRails.config do |config|
        config.table_name 'ubigeo_ubigeo'
        config.db_connection { "general_#{Rails.env}" }
      end

# TODO

- Realizar estas tareas para eliminar la segunda asunción:
    - Generator If migration is needed: rails g ubigeo_rails:migration : id, name and parent_id, timestamps
    - Generator if seed is needed: rails g ubigeo_rails:seeds