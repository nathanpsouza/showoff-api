# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Widget, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:kind) }
    it do
      is_expected.to validate_inclusion_of(:kind)
        .in_array(['visible', 'hidden'])
    end
  end
end
