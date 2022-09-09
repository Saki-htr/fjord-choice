# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Issues', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/api/issues/create'
      expect(response).to have_http_status(:success)
    end
  end
end
