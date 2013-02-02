Backlog::Application.routes.draw do
  resources :backlogs, controller: "logs", as: "logs" do
    resources :log_items do
      put 'position', on: :member
    end
  end

  devise_for :users

  root to: "logs#index"
end
