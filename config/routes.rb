# frozen_string_literal: true

Rails.application.routes.draw do
  root 'baskets#show'

  namespace :basket, module: 'baskets' do
    resources :items, only: %i[create update]
    resources :promotions, only: %i[create destroy]
  end

  post 'basket/checkout' => 'baskets#checkout', as: 'checkout'
end
