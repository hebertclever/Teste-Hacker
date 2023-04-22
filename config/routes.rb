Rails.application.routes.draw do
  resources :report, only: [:create]
end
