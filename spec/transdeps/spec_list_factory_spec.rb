require 'spec_helper'
require 'transdeps/spec_list_factory'

module Transdeps
  describe SpecListFactory do
    it 'returns a speclist for given dir' do
      lockfile = DUMMY_APP_PATH + 'Gemfile.lock'
      expect(File).to receive(:read).with(lockfile).and_return('stuff')

      speclist = SpecList.new DUMMY_APP_PATH + 'Gemfile.lock', 'stuff'
      result = SpecListFactory.new.call(DUMMY_APP_PATH)
      expect(result.lock_file_path).to eq(speclist.lock_file_path)
      expect(result.lock_file_contents).to eq(speclist.lock_file_contents)
    end
  end
end