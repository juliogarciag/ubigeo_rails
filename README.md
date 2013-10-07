# Ubigeo Rails

## Asunciones

- Usas Formtastic (posiblemente a futuro se haga algo para SimpleForm pero Formtastic está bien)

## Instalación

Agrega la gema al Gemfile
    
    gem 'ubigeo_rails'
    
Instala la gema, lo que creará una ruta y un inicializador

    rails g ubigeo_rails:install

## La ruta

Por defecto, la engine será montada en `/ubigeo`. Puedes revisar el código generado en `config/routes.rb` para cambiar el punto de montaje. Puedes montarlo en la ruta que desees.

## Uso

### Uso del Plugin

Puedes usarlo algo así. La opción `as` con el valor `:ubigeo` es la que permitirá usar el plugin. La única opción por el momento es `prompt`, que te permitirá elegir los 3 elementos vacíos que puede haber sobre cada uno de los 3 selects que conforman el plugin.

    # Imaginemos un formulario para un usario
    = semantic_form_for @user do |f|
      = f.input :ubigeo_id, as: :ubigeo, prompt: ["selecciona un departamento", "selecciona una provincia", "selecciona un distrito"]

### Ubigeo.js

La parte interesante de esta gema (y lo que te puede ahorrar tiempo) es el archivo de javascript que incluye. Una vez incluido transformará en selects dependientes a todos los elementos creados por el plugin de formtastic, así que no debrás hacer nada sino quizás inspeccionar el código generado. Para incluir el javascript, sólo realiza lo siguiente en un manifiesto (como `app/assets/application.js`):

    //= require ubigeo

### Asociaciones

Para asociar el modelo a otro, debes especificar la clase exacta de Ubigeo. Por ejemplo:

    class User << ActiveRecord::Base
      belongs_to :ubigeo, class_name: "UbigeoRails::Ubigeo"
    end

## Enlazar a algo de información

### Si ya tienes una tabla de Ubigeo

Edita el inicializador (en app/config/initializers/ubigeo_rails.rb) con datos como los siguientes:

    UbigeoRails.config do |config|
      config.table_name 'ubigeo_ubigeo'
      config.db_connection { "general_#{Rails.env}" }
    end

La razón principal de estas opciones es para poder conectar a bases de datos ya existentes.

### Si no la tienes

Si no tienes una bd ya existente, puedes llenar la base de datos de ubigeo en dos pasos:

Crear la tabla:

    rails g migration create_ubigeos name:string parent_id:integer
    rake db:migrate 

Generar los seeds (la información):

    rails g ubigeo_rails:seeds

El primero creará una migración y el segundo agregará código al archivo `seeds.rb` que permitirá generar la data usando el estándar:

    rake db:seed


## Modelo

También puedes usar los siguientes métodos de la clase Ubigeo:

- **#has_department?**: Si el código de ubigeo contiene o no la información de un departamento
- **#has_province?**: Si el código de ubigeo contiene o no la información de una provincia
- **#has_district?**: Si el código de ubigeo contiene o no la información de un distrito
- **.with_parent**: Devuelve los hijos de un ubigeo. Por ejemplo, los distritos de Lima o las provincias de Arequipa.