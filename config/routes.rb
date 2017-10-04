Rails.application.routes.draw do
	root 'clearance/sessions#new'
	match '/auth/:provider/callback', to: 'sessions#create', via: :all
	delete '/logout', to: 'sessions#destroy', as: :logout

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
