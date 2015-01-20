Rails.application.routes.draw do
  resources :imports, only: [:new, :create]

end
