require 'spec_helper'
require 'transdeps/spec_list_factory'

module Transdeps
  describe SpecListFactory do
    it 'returns a speclist for given dir' do
      lockfile = DUMMY_APP_PATH + 'Gemfile.lock'
      expect(File).to receive(:read).with(lockfile).and_return('stuff')

      speclist = SpecList.new 'stuff'
      expect(SpecListFactory.new.call(DUMMY_APP_PATH)).to eq(speclist)
    end
  end
end