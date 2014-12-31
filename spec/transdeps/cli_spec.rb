require 'spec_helper'
require 'transdeps/cli'

module Transdeps
  describe Cli do
    it 'uses the reconciles dependencies' do
      reconciler = double('Reconciler', call: [])
      cli = Cli.new('components', 'root', reconciler)
      expect(reconciler).to receive(:call).with(Pathname('components'), Pathname('root'))
      cli.run
    end
  end
end
