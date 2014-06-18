Modelunitednations::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  devise_for :users, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout'}, :controllers  => {:registrations => 'devise/signups', :omniauth_callbacks => "users/omniauth_callbacks" } do
    get   "auth/registration" => "devise/registrations#new", :as => :user
    post "auth/registration" => "devise/registrations#create", :as => :user
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end


  root to: "welcome#index"
  get "theme", to: 'welcome#theme'

  resources :conferences do
    member do
      get 'placards'
    end
  end
  resources :committees do
    member do
      get 'session'
    end
  end
  resources :committee_sessions
  resources :delegations
  resources :delegates
  resources :users do
    member do
      get 'settings'
      get 'intro'
    end
  end
  resources :participants
  resources :participant_groups do
    member do
      get 'invite'
      post 'invite'
      get 'join'

    end
  end
  resources :participant_group_members
  resources :resolutions
  resources :position_papers
  resources :topics
  resources :registrations do
    member do
      put 'withdraw'
      put 'accept'
      put 'reject'
    end
  end

  resources :group_registrations do
    member do
      put 'withdraw'
      put 'accept'
      put 'reject'
    end
  end
  resources :timetables
  resources :events
  resources :announcements

  namespace :api do
    namespace :v1 do
      resources :committees
    end
  end



  # The priority is based upon order of creation: first created -> highest priority.

  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"




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
