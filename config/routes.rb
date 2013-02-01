Backlog::Application.routes.draw do
  resources :backlogs, controller: "logs", as: "logs" do
    resources :log_items
  end

  devise_for :users

  root to: "logs#index"
end
