Rails.application.routes.draw do
  get '/products', to: 'products#index'
  get 'products/save_data'
  get "products/delete_row"
  get "products/create_row"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
