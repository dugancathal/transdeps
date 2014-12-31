require 'bundler/lockfile_parser'
require 'transdeps/specification'

module Transdeps
  class SpecList < Struct.new(:lock_file, :generator)
    def initialize(lock_file, generator=Bundler::LockfileParser)
      super
    end

    def specs
      parser.specs.map do |spec|
        Specification.from_lock(spec.to_s)
      end
    end

    private
    def parser
      @parser ||= generator.new(lock_file.to_s)
    end
  end
end