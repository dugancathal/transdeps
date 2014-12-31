require 'spec_helper'
require 'transdeps/specification'

describe Transdeps::Specification do
  describe '.from_lock' do
    it 'initializes the name and version from the lock string' do
      lock = 'rake (10.0.0)'
      spec = Transdeps::Specification.from_lock(lock)
      expect(spec.name).to eq 'rake'
      expect(spec.version).to eq '10.0.0'
    end

    it 'works for dasherized spec-names' do
      lock = 'rake-lib (10.0.0)'
      spec = Transdeps::Specification.from_lock(lock)
      expect(spec.name).to eq 'rake-lib'
      expect(spec.version).to eq '10.0.0'
    end

    it 'works for underscored names' do
      lock = 'rake_lib (10.0.0)'
      spec = Transdeps::Specification.from_lock(lock)
      expect(spec.name).to eq 'rake_lib'
      expect(spec.version).to eq '10.0.0'
    end
  end
  describe 'equality' do
    it 'is equal when the name and version are equal' do
      version1 = Transdeps::Specification.new('rake', '10.0.0')
      version2 = Transdeps::Specification.new('rake', '10.0.0')
      expect(version1).to eq version2
    end
  end
end
