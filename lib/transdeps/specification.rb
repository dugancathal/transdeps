module Transdeps
  class Specification < Struct.new(:name, :version)
    def self.from_lock(lock)
      match = lock.match(/^(?<name>[\w\-]+) \((?<version>.*)\)/)
      new(match[:name], match[:version])
    end

    def to_s
      "#{name} (#{version})"
    end
  end
end
