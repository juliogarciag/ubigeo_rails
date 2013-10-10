# Ubigeo Rails

## ¿Qué es Ubigeo?

Bueno, en cierto país donde nací(Perú), el ubigeo es un número de identificación que identifica a un departamento, provincia o distrito del país, algo así:

  * Departamento de Lima: 15
  * Provincia de Lima: 1501
  * Distrito de Lima: 150101

Esta gema es una abstracción de dos acciones relacionadas a este concepto, que son:

1. Endpoints de json que nos dan las provincias de una departamento.
2. Una librería de Javascript que abstrae la idea de selectores dependientes que es el widget más usado para ingresar información de ubigeo en internet.

## Asunciones

- Usas Formtastic (posiblemente a futuro se haga algo para SimpleForm o alguna opción más agnóstica como un helper que funcione como un widget)

## Uso

### Instalación

Agrega la gema al Gemfile
    
    gem 'ubigeo_rails'
    
Luego, instala la gema, lo que creará una ruta y un inicializador.

    rails g ubigeo_rails:install

Agrega la siguiente librería a tu manifiesto (`app/assets/application.js`):

    //= require ubigeo


### Llena el Ubigeo

#### Si ya tienes una tabla de Ubigeo

Edita el inicializador (en app/config/initializers/ubigeo_rails.rb) con datos como los siguientes:

    UbigeoRails.config do |config|
      config.table_name 'ubigeo_ubigeo'
      config.db_connection { "general_#{Rails.env}" }
    end

La razón principal de estas opciones es para poder conectar a bases de datos ya existentes.

#### Si no la tienes

Si no tienes una bd ya existente, puedes llenar la base de datos de ubigeo en dos pasos:

Crear la tabla:

    rails g migration create_ubigeos name:string parent_id:integer
    rake db:migrate 

Generar los seeds (la información):

    rails g ubigeo_rails:seeds

El primero creará una migración y el segundo agregará código al archivo `seeds.rb` que permitirá generar la data usando el estándar:

    rake db:seed

### Crea una relación

Para asociar el modelo de Ubigeo a otro, debes especificar la clase exacta de Ubigeo, que es `UbigeoRails::Ubigeo`. Por ejemplo, si queremos asociarla a un usuario:

    class User << ActiveRecord::Base
      belongs_to :ubigeo, class_name: "UbigeoRails::Ubigeo"
    end


### Úsala en un formulario

Puedes usarlo el plugin como cualquier input de Formtastic. Sólo debes colocar el valor `:ubigeo` en la opción `:as`:

    # Imaginemos un formulario para un usario
    = semantic_form_for @user do |f|
      = f.input :ubigeo_id, as: :ubigeo, prompt: ["selecciona un departamento", "selecciona una provincia", "selecciona un distrito"]

La única opción por el momento es `prompt`, que te permitirá elegir los 3 elementos vacíos que puede haber sobre cada uno de los 3 selects que conforman el plugin. De no necesitar este prompt, simplemente no lo colocamos.


## Extras

### La Ruta

Por defecto, la engine (esto es una rails engine) será montada en `/ubigeo`. Puedes revisar el código generado en `config/routes.rb` para cambiar el punto de montaje.

### El Modelo

También puedes usar los siguientes métodos de la clase Ubigeo:

- **#has_department?**: Si el código de ubigeo contiene o no la información de un departamento
- **#has_province?**: Si el código de ubigeo contiene o no la información de una provincia
- **#has_district?**: Si el código de ubigeo contiene o no la información de un distrito
- **.with_parent(id)**: Devuelve los hijos de un ubigeo. Por ejemplo, los distritos de Lima o las provincias de Arequipa.