module Transdeps
  class Specification < Struct.new(:name, :version, :project_path)
    def self.from_lock(lock, path='')
      match = lock.match(/^(?<name>[\w\-]+) \((?<version>.*)\)/)
      new(match[:name], match[:version], path)
    end

    def same_gem_as?(other)
      name == other.name
    end

    def =~(other)
      same_gem_as?(other) && version == other.version
    end

    def to_s
      "#{name} (#{version})"
    end
  end
end
