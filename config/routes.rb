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