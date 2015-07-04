Rails.application.routes.draw do
  mount Crono::Web, at: "/crono"

  root "packages#index"
end
