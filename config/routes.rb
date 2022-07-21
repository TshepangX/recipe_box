Rails.application.routes.draw do
  root "recipes#index"

  resources :ingredients
  resources :tags
  resources :recipes do
    resources :ratings
  end
end
