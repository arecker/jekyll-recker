# frozen_string_literal: true

require_relative 'spec_helper.rb'

class Dog
  include JekyllRecker::Mixins::Logging
  include JekyllRecker::Mixins::Introspection
end

class PembrokeWelshCorgi < Dog; end
class CardiganWelshCorgi < Dog; end
class GoldenRetriever < Dog; end

describe JekyllRecker::Mixins::Introspection do
  describe '.class_name' do
    it 'should return the class name' do
      expect(Dog.new.class_name).to eq('Dog')
    end
  end

  describe '.descendants' do
    it 'should iterate over each child class' do
      expected = [PembrokeWelshCorgi, CardiganWelshCorgi, GoldenRetriever]
      expect(Dog.descendants).to match_array(expected)
    end
  end
end

describe JekyllRecker::Mixins::Logging do
  describe '.logger' do
    it 'should return logger' do
      expect(Dog.logger).to be_a(Logger)
    end
  end

  describe '#logger' do
    it 'should return logger' do
      expect(Dog.new.logger).to be_a(Logger)
    end
  end
end
