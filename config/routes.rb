# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :application_events
  resources :job_events
  resources :applications, only: %i[show index]
  resources :jobs, only: %i[show index]
end
