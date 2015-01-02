module Transdeps
  class Inconsistency < Struct.new(:expected, :actual)
    def to_s
      "%-<expected>30s != %-<actual>30s (%-<component>30s)" % {
        expected: expected,
        component: actual.project_path.split('/').last,
        actual: actual,
      }
    end
  end
end