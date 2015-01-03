require 'spec_helper'
require 'transdeps/spec_list'

module Transdeps
  describe SpecList do
    it 'delegates the :specs method to the generator' do
      generator = double(Bundler::LockfileParser, new: nil, specs: [])
      expect(generator).to receive(:specs)
      list = SpecList.new('Gemfile.lock', 'contents', generator)
      list.specs
    end

    it 'returns a Specification for each spec' do
      generator = double(Bundler::LockfileParser, specs: ['rake (10.0.0)'])
      list = SpecList.new('Gemfile.lock', 'contents', generator)
      allow(list).to receive(:parser).and_return(generator)
      expect(list.specs).to eq([Specification.from_lock('rake (10.0.0)', '.')])
    end

    it "sets the specification project_path to the lock_file's directory" do
      generator = double(Bundler::LockfileParser, specs: ['rake (10.0.0)'])
      list = SpecList.new('/path/to/Gemfile.lock', 'contents', generator)
      allow(list).to receive(:parser).and_return(generator)
      expect(list.specs).to eq([Specification.from_lock('rake (10.0.0)', '/path/to')])
    end

    it 'allows findingy by gem name' do
      generator = double(Bundler::LockfileParser, specs: ['rake (10.0.0)'])
      list = SpecList.new('/path/to/Gemfile.lock', 'contents', generator)
      allow(list).to receive(:parser).and_return(generator)
      expect(list['rake']).to eq(Specification.from_lock('rake (10.0.0)', '/path/to'))
    end

    describe '-=' do
      it 'returns a list of the inconsistencies' do
        ten_dot_oh = Specification.from_lock('rake (10.0.0)', '.')
        ten_dot_one = Specification.from_lock('rake (10.1.0)', '.')
        project_generator = double(Bundler::LockfileParser, specs: [ten_dot_oh])
        project_list = SpecList.new('Gemfile.lock', 'contents', project_generator)

        component_generator = double(Bundler::LockfileParser, specs: [ten_dot_one])
        component_list = SpecList.new('Gemfile.lock', 'contents', component_generator)

        expect(project_list - component_list).to eq([Inconsistency.new(ten_dot_oh, ten_dot_one)])
      end

      it 'is agnostic to project_path' do
        ten_dot_oh = Specification.from_lock('rake (10.0.0)', '/first/path')
        ten_dot_one = Specification.from_lock('rake (10.0.0)', '/other/path')
        project_generator = double(Bundler::LockfileParser, specs: [ten_dot_oh])
        project_list = SpecList.new('/first/Gemfile.lock', 'contents', project_generator)

        component_generator = double(Bundler::LockfileParser, specs: [ten_dot_one])
        component_list = SpecList.new('/other/Gemfile.lock', 'contents', component_generator)

        expect(project_list - component_list).to eq([])
      end
    end
  end
end