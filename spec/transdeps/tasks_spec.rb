require 'transdeps/tasks'

describe 'rake' do
  describe 'transdeps' do
    let(:cli) { double(Transdeps::Cli, run: nil) }
    before do
      Rake::Task['transdeps'].reenable
      allow(Transdeps::Cli).to receive(:new).and_return(cli)
    end

    context 'with two arguments' do
      it 'calls Cli.run' do
        Rake.application.invoke_task 'transdeps[component_dir,root_dir]'

        expect(Transdeps::Cli).to have_received(:new).with 'component_dir', 'root_dir'
        expect(cli).to have_received(:run)
      end
    end

    context 'with one argument' do
      it 'calls Cli.run' do
        Rake.application.invoke_task 'transdeps[component_dir]'

        expect(Transdeps::Cli).to have_received(:new).with 'component_dir'
        expect(cli).to have_received(:run)
      end

      it 'prints a warning that the root dir is PWD' do
        expect do
          Rake.application.invoke_task 'transdeps[component_dir]'
        end.to output(/WARNING: Using PWD as project root_dir/).to_stderr
      end
    end
  end
end