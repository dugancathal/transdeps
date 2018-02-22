require 'transdeps/spec_list_factory'
require 'transdeps/inconsistency'

module Transdeps
  class Reconciler < Struct.new(:factory)
    def initialize(factory=SpecListFactory.new)
      super
    end

    def call(component_dir, project_dir)
      project_specs = specs_for(project_dir)
      all_component_specs = all_component_specs(component_dir)

      spec_differences(project_specs, all_component_specs)
    end

    private

    def specs_for(dir)
      factory.call(dir)
    end

    def all_component_specs(component_dir)
      component_dir
        .children
        .select { |filename| File.directory?(filename) }
        .map { |dir| specs_for(dir) }
    end

    def spec_differences(project_specs, all_component_specs)
      all_component_specs.flat_map do |component_specs|
        project_specs - component_specs
      end.compact
    end
  end
end
