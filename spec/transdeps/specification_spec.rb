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

  describe 'match-y-ness' do
    it 'matches when the name is the same' do
      version1 = Transdeps::Specification.new('rake', '10.0.0')
      version2 = Transdeps::Specification.new('rake', '10.0.0')
      expect(version1 =~ version2).to be_truthy
    end

    it 'does not match when the name is the same and the version is different' do
      version1 = Transdeps::Specification.new('rake', '10.0.0')
      version2 = Transdeps::Specification.new('rake', '10.1.0')
      expect(version1 =~ version2).to be_falsey
    end

    it 'does not care what the project path is' do
      version1 = Transdeps::Specification.new('rake', '10.0.0', 'path1')
      version2 = Transdeps::Specification.new('rake', '10.0.0', 'path2')
      expect(version1 =~ version2).to be_truthy
    end
  end

  describe 'equality' do
    it 'is equal when the name, version, and project_path are equal' do
      version1 = Transdeps::Specification.new('rake', '10.0.0', 'path')
      version2 = Transdeps::Specification.new('rake', '10.0.0', 'path')
      expect(version1 === version2).to be_truthy
    end
  end

  describe '#same_gem_as?' do
    it 'returns true when the gem names are the same' do
      version1 = Transdeps::Specification.new('rake', '10.0.0')
      version2 = Transdeps::Specification.new('rake', '10.0.0')
      expect(version1).to be_same_gem_as version2
    end

    it 'returns true when the gem names are the same and versions are different' do
      version1 = Transdeps::Specification.new('rake', '10.1.0')
      version2 = Transdeps::Specification.new('rake', '10.0.0')
      expect(version1).to be_same_gem_as version2
    end

    it 'returns false when the gem names are the different' do
      version1 = Transdeps::Specification.new('rake', '10.0.0')
      version2 = Transdeps::Specification.new('rack', '10.0.0')
      expect(version1).to_not be_same_gem_as version2
    end
  end
end
