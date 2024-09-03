Rails.application.routes.draw do
  namespace :v1 do
    resources :geolocations, only: [ :show, :create, :destroy ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
