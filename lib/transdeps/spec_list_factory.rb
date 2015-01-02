require 'transdeps/spec_list'
module Transdeps
  class SpecListFactory
    def call(dir)
      SpecList.new(dir + 'Gemfile.lock', File.read(dir + 'Gemfile.lock'))
    end
  end
end