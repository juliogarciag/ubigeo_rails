# Ubigeo Rails

## Asunciones

- Usas Formtastic (posiblemente a futuro se haga algo para SimpleForm pero Formtastic está bien)

## Instalación

Agrega la gema al Gemfile
    
    gem 'ubigeo_rails'
    
Instala la gema, lo que creará una ruta y un inicializador

    rails g ubigeo_rails:install

## Configuración

Edita el inicializador (en app/config/initializers/ubigeo_rails.rb) con datos como los siguientes:

    UbigeoRails.config do |config|
      config.table_name 'ubigeo_ubigeo'
      config.db_connection { "general_#{Rails.env}" }
    end

La razón principal de estas opciones es para poder conectar a bases de datos ya existentes.

## Información

Si no tienes una bd ya existente, puedes llenar la base de datos de ubigeo en dos pasos:

Crear la tabla:

    rails g migration create_ubigeos name:string parent_id:integer
    rake db:migrate 

Generar los seeds (la información):

    rails g ubigeo_rails:seeds

El primero creará una migración y el segundo agregará código al archivo `seeds.rb` que permitirá generar la data:

    rake db:seed

## Asociaciones

Para asociar, debes especificar la clase exacta de Ubigeo. Por ejemplo:

    class User < < ActiveRecord::Base
      belongs_to :ubigeo, class_name: "UbigeoRails::Ubigeo"
    end