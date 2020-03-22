# frozen_string_literal: true
require 'rails_helper'
require 'factory_girl_rails'
module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = ::FactoryGirl.create(:user)
      sign_in user
    end
  end
end
