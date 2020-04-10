# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST #create' do
    let(:email) { 'foo@rspec.com' }
    let(:first_name) { 'rspec' }
    let(:last_name) { 'test' }
    let(:password) { '123123123' }

    let(:user) do
      {
        email: email,
        first_name: first_name,
        last_name: last_name,
        password: password
      }
    end

    let(:headers) { { 'CONTENT-TYPE': 'application/json' } }

    context 'with valid data' do
      before do
        VCR.use_cassette('post_valid_user') do
          post '/users', params: { user: user }.to_json, headers: headers
        end
      end

      it 'return http status created' do
        expect(response).to have_http_status(:created)
      end

      it 'return user data on json' do
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('success')
        expect(json_response['data'].keys).to contain_exactly('token', 'user')
      end
    end

    context 'with invalid data' do
      let(:email) { nil }
      before do
        VCR.use_cassette('post_invalid_user') do
          post '/users', params: { user: user }.to_json, headers: headers
        end
      end

      it 'return http status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'return errors on json' do
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('error')
        expect(json_response['data']['errors']).to_not be_empty
      end
    end
  end
end
