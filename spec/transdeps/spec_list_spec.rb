require 'spec_helper'
require 'transdeps/spec_list'

module Transdeps
  describe SpecList do
    it 'delegates the :specs method to the generator' do
      generator = double(Bundler::LockfileParser, new: nil, specs: [])
      allow(generator).to receive(:new).and_return(generator)
      expect(generator).to receive(:specs)
      list = SpecList.new('Gemfile.lock', generator)
      list.specs
    end

    it 'returns a Specification for each spec' do
      generator = double(Bundler::LockfileParser, specs: ['rake (10.0.0)'])
      list = SpecList.new('Gemfile.lock', generator)
      allow(list).to receive(:parser).and_return(generator)
      expect(list.specs).to eq([Specification.from_lock('rake (10.0.0)')])
    end
  end
end