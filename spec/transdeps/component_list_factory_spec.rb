require 'spec_helper'
require 'tmpdir'
require 'transdeps/component_list_factory'

module Transdeps
  describe ComponentListFactory do
    subject { Transdeps::ComponentListFactory.new }

    around(:each) do |example|
      Dir.mktmpdir do |dir|
        Dir.chdir(dir) do
          Dir.mkdir('components')
          Dir.mkdir(component_a)
          Dir.mkdir(component_b)

          File.open(dummy_file, 'w') { }

          example.run
        end
      end
    end

    let (:component_a) { File.join('components', 'componentA') }
    let (:component_b) { File.join('components', 'componentB') }
    let (:dummy_file) { File.join('README.md') }

    it 'returns Pathnames to directories inside a given component_dir' do
      component_dir = double(
        Dir,
        children: [
          Pathname.new(component_a),
          Pathname.new(dummy_file),
          Pathname.new(component_b)
        ]
      )

      components = subject.call(component_dir)

      expect(components).to match_array(
        [
          Pathname.new(component_a),
          Pathname.new(component_b)
        ]
      )
    end
  end
end
