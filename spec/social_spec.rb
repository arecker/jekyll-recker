# frozen_string_literal: true

require_relative 'spec_helper.rb'

class Dummy < JekyllRecker::Social::Share  
end

describe JekyllRecker::Social::Share do
  describe '.config_key' do
    it 'get the config key from class name' do
      dummy = Dummy.new
      expect(dummy.config_key).to eq('dummy')
    end
  end
end
