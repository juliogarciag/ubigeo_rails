# Assumptions

- You use Formtastic

# TODO

- Generator If migration is needed: rails g ubigeo_rails:migration : id, name and parent_id, timestamps
- Generator if seed is needed: rails g ubigeo_rails:seeds
- Generator to initialize everything: rails g ubigeo_rails:install, to include `rails g ubigeo_rails:config` y `mount UbigeoRails::Engine, at: "ubigeo"`