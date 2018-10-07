# frozen_string_literal: true

Rails.application.routes.draw do
  resources :restaurants, param: :local_id do
    collection do
      get 'statistics'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
