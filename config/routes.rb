# frozen_string_literal: true

Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :feedback_responses, only: %i[create index]
      resources :feedback_search do
        collection do
          get "search", to: "feedback_search#search"
          get "structure_stats", to: "feedback_search#structure_stats"
          get "location_stats", to: "feedback_search#location_stats"
        end
      end
    end
  end
end
