require 'spec_helper'
require 'transdeps/reconciler'

module Transdeps
  describe Reconciler do
    it 'gathers specs for each component' do
      factory = SpecListFactory.new
      rec = Reconciler.new(factory)

      expect(factory).to receive(:call).with(DUMMY_APP_PATH).and_return(3)
      expect(factory).to receive(:call).with(DUMMY_APP_PATH + 'components/invalid-sub-dependencies').and_return(4)
      expect(factory).to receive(:call).with(DUMMY_APP_PATH + 'components/obviously-invalid-dependencies').and_return(5)
      expect(factory).to receive(:call).with(DUMMY_APP_PATH + 'components/obviously-valid-dependencies').and_return(6)

      result = rec.call(DUMMY_APP_PATH + 'components', DUMMY_APP_PATH)

      expect(result).to eq [3,4,5,6]
    end

    it ''
  end
end
