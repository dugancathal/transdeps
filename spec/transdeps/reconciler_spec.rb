require 'spec_helper'
require 'transdeps/reconciler'

module Transdeps
  describe Reconciler do
    it 'returns the set of specs that are inconsistent between the components' do
      factory = SpecListFactory.new
      rec = Reconciler.new(factory)
      component_dir = double(Dir, children: [DUMMY_APP_PATH + 'components/invalid-sub-dependencies'])

      ten_dot_oh = Specification.from_lock('rake (10.0.0)')
      ten_dot_one = Specification.from_lock('rake (10.1.0)')
      expect(factory).to receive(:call).with(DUMMY_APP_PATH) do
        list = SpecList.new('Gemfile.lock', double)
        allow(list).to receive(:specs).and_return([ten_dot_oh])
        list
      end
      expect(factory).to receive(:call).with(DUMMY_APP_PATH + 'components/invalid-sub-dependencies') do
        list = SpecList.new('Gemfile.lock', double)
        allow(list).to receive(:specs).and_return([ten_dot_one])
        list
      end

      result = rec.call(component_dir, DUMMY_APP_PATH)

      expect(result).to eq [Inconsistency.new(ten_dot_oh, ten_dot_one)]
    end
  end
end
