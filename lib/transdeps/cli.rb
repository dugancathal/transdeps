require 'pathname'
require 'transdeps/reconciler'

module Transdeps
  class Cli
    attr_reader :component_dir, :project_root, :reconciler
    def initialize(component_dir, project_root=Pathname('.'), reconciler=Reconciler.new)
      @component_dir = Pathname(component_dir)
      @project_root = Pathname(project_root)
      @reconciler = reconciler
    end

    def run
      reconciler.call(component_dir, project_root)
    end
  end
end
