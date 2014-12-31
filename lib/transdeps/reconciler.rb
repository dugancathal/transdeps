require 'transdeps/spec_list_factory'

module Transdeps
  class Reconciler
    attr_reader :factory
    def initialize(spec_list_factory=SpecListFactory.new)
      @factory = spec_list_factory
    end

    def call(component_dir, project_dir)
      ([project_dir] + component_dir.children).map do |dir|
        factory.call(dir)
      end
    end
  end
end
