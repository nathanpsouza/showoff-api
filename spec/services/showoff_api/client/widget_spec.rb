# frozen_string_literal: true

require 'rails_helper'

module ShowoffApi
  module Client
    describe Widget do
      let(:widget_client) do
        t = 'f311c6ac1a39c0eb29a41ff602319b618e54381786e457f4cab08a10e700a72b'
        Widget.new(
          t, ENV['API_ADDRESS'], ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
        )
      end

      describe 'widgets' do
        let(:cassette_name) { 'get_widgets' }
        it 'return widgets in data attribute' do
          VCR.use_cassette(cassette_name) do
            result = widget_client.widgets
            expect(result[:data][:widgets].size).to eq(1)
            keys = ['id', 'name', 'description', 'kind', 'user', 'owner']
            expect(result[:data][:widgets][0].keys).to contain_exactly(*keys)
          end
        end

        it 'return success in status attribute' do
          VCR.use_cassette(cassette_name) do
            result = widget_client.widgets
            expect(result[:status]).to eq(:success)
          end
        end

        it 'return hash with indifferent access' do
          VCR.use_cassette(cassette_name) do
            result = widget_client.widgets
            expect(result).to be_a_kind_of(
              ActiveSupport::HashWithIndifferentAccess
            )
          end
        end
      end

      describe 'save' do
        let(:name) { 'rspec widget' }
        let(:description) { 'rspec widget' }
        let(:kind) { 'hidden' }

        let(:widget) do
          {
            name: name,
            description: description,
            kind: kind
          }
        end

        context 'with valid data' do
          let(:cassette_name) { 'post_valid_hidden_widget' }
          it 'return user in data attribute' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.save(widget)
              expect(result[:data][:widget]).to be_present
            end
          end

          it 'return success in status attribute' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.save(widget)
              expect(result[:status]).to eq(:success)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.save(widget)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end

        context 'with invalid data' do
          let(:name) { nil }
          let(:cassette_name) { 'post_invalid_hidden_widget' }

          it 'return error message in data attribute' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.save(widget)
              expect(result[:data]).to eq('Name can\'t be blank')
            end
          end

          it 'return error in status attribute' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.save(widget)
              expect(result[:status]).to eq(:error)
            end
          end

          it 'return hash with indifferent access' do
            VCR.use_cassette(cassette_name) do
              result = widget_client.save(widget)
              expect(result).to be_a_kind_of(
                ActiveSupport::HashWithIndifferentAccess
              )
            end
          end
        end
      end
    end
  end
end
