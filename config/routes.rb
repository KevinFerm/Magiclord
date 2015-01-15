Rails.application.routes.draw do

  resources :magic_parts

  resources :pearls

  resources :battles

  get 'item/index'

  devise_for :users, :controllers => { registrations: 'registrations_' }
  get 'home/index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  post 'worlds/generate_new_area' => "worlds#generate_new_area"
  post 'worlds/claim_area' => "worlds#claim_area"
  post 'worlds/attack' => "worlds#attack"
  post 'battles/escape' => "battles#escape"
  post 'battles/join' => "battles#join"
  post 'worlds/search_location' => "worlds#search_location"
  post 'worlds/collect_world_item' => "worlds#collect_world_item"
  post 'worlds/teleport' => "worlds#get_teleport"
  get 'worlds/teleport' => "worlds#teleport"
  post 'item/item_action' => "item#item_action"
  resources :characters do
    resource :items
  end
  resources :worlds
  resources :guide
  resources :item
  resources :npc
  resources :lock
  resources :inventory do
    resources :items
  end

  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
  end
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
