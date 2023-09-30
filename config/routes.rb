Rails.application.routes.draw do
  root to: "pages#home"
  resources :recipes do
    collection do
      get :search
    end
  end
end
