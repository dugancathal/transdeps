require 'bundler/lockfile_parser'
require 'transdeps/specification'
require 'transdeps/inconsistency'

module Transdeps
  class SpecList < Struct.new(:lock_file_path, :lock_file_contents, :parser)
    def initialize(lock_file_path, lock_file_contents, parser=Bundler::LockfileParser.new(lock_file_contents.to_s))
      lock_file_path = Pathname(lock_file_path)
      super(lock_file_path, lock_file_contents, parser)
    end

    def specs
      parser.specs.map do |spec|
        Specification.from_lock(spec.to_s, lock_file_path.dirname.to_s)
      end
    end

    def -(other)
      specs.map do |spec|
        if other_spec = other.specs.find {|other_spec| spec.same_gem_as?(other_spec) }
          unless spec === other_spec
            Inconsistency.new(spec, other_spec)
          end
        end
      end.compact
    end
  end
end