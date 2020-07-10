# frozen_string_literal: true

require_relative 'spec_helper.rb'

class Dummy < Jekyll::Recker::Social::Share
  
end

describe Jekyll::Recker::Social::Share do
  describe '.config_key' do
    it 'get the config key from class name' do
      dummy = Dummy.new
      expect(dummy.config_key).to eq('dummy')
    end
  end
end
