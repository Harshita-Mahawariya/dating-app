Rails.application.routes.draw do
  get "/healthcheck", to: proc { [200, {}, ["Ok"]] }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :bx_block_splashscreen2 do
    resources :splash_screens
  end

  namespace :bx_block_contact_us do
    resources :contacts
  end

  namespace :bx_block_privacy_settings do
    get 'tc', to: 'terms_and_conditions#terms'
  end

  namespace :bx_block_knowyourcustomerkycverification2 do
    post '/applicant_create', to: 'onfidos#applicant_create'
    post '/onfido_response', to: 'onfidos#webhook_response'
    get '/retrieve_onfido_report', to: 'onfidos#retrieve_onfido_report'
  end

  namespace :account_block do
    resources :accounts
  end

  namespace :bx_block_forgot_password do
    resources :otps
    resources :otp_confirmations
  end

  namespace :bx_block_login do
    resources :logins
    resources :social_login
  end
end
