require 'transdeps/spec_list'
module Transdeps
  class SpecListFactory
    def call(dir)
      SpecList.new(File.read(dir + 'Gemfile.lock'))
    end
  end
end