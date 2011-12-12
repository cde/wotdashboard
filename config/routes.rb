Wotdashboard::Application.routes.draw do
  resources :reports

  match "funnels" => "funnels#index", :as => :funnels
  match "funnels/normal/:start/:end/:traffic_type" => "funnels#get_data_normal", :as => :funnels_get_data_normal
  match "funnels/adquisition/:start/:end/:traffic_type" => "funnels#get_data_adquisition", :as => :funnels_get_data_adquisition
  post "funnels/save_report" => "funnels#save_report"
  post "funnels/update_report" => "funnels#update_report"
  post "results" => "home#results", :as => :home_results
  match "preview" => "funnels#preview", :as => :funnels_preview
  match "process/:data_file" => "funnels#process_file", :as => :funnels_process_file

  match ":id/:title" => "home#get_report", :as => :get_report, :constraints => {:id => /[0-9]+/}

  devise_for :users, :controllers => {:sessions => 'devise/sessions'}, :skip => [:sessions] do
      get 'login' => 'devise/sessions#new', :as => :new_user_session
      post 'login' => 'devise/sessions#create', :as => :user_session
      get 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
root :to => 'home#index'
end
=======

  resources :reports

  match "funnels" => "funnels#index", :as => :funnels
  match "funnels/normal/:start/:end/:traffic_type" => "funnels#get_data_normal", :as => :funnels_get_data_normal
  match "funnels/adquisition/:start/:end/:traffic_type" => "funnels#get_data_adquisition", :as => :funnels_get_data_adquisition
  post "funnels/save_report" => "funnels#save_report"
  post "funnels/update_report" => "funnels#update_report"
  post "results" => "home#results", :as => :home_results
  match "preview" => "funnels#preview", :as => :funnels_preview
  match "process/:data_file" => "funnels#process_file", :as => :funnels_process_file

  match ":id/:title" => "home#get_report", :as => :get_report


  devise_for :users, :controllers => {:sessions => 'devise/sessions'}, :skip => [:sessions] do
      get 'login' => 'devise/sessions#new', :as => :new_user_session
      post 'login' => 'devise/sessions#create', :as => :user_session
      get 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
>>>>>>> 666b9515b4486297427710621de0d25f42deacc6
