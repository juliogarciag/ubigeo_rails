UbigeoRails::Engine.routes.draw do
  get '/(:id)', to: 'ubigeo_rails/ubigeos#show', as: :ubigeo
end