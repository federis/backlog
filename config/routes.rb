Backlog::Application.routes.draw do
  resources :backlogs, controller: "logs", as: "logs" do
    resources :log_items do
      put 'position', on: :member
    end

    resources :collaborations
  end

	 devise_for :users do
	    get "/users/sign_in" => "devise/sessions#new"
	    get "/users/sign_out" => "devise/sessions#destroy"
	 end

  root to: "logs#index"
end
