require_relative '../../../../lib/mdt/commands/simple'

RSpec.describe MDT::Commands::Simple do
  it 'should have the "simple" key defined' do
    expect { MDT::Commands::Simple.key }.not_to raise_error
    expect(MDT::Commands::Simple.key).to eq('simple')
  end

  it 'should have "shell", "system", "mkdir", "cd", "cp", "mv", "rm", "ln", "chmod", "chown" and "touch" subkeys' do
    expect { MDT::Commands::Simple.subkeys }.not_to raise_error
    expect(MDT::Commands::Simple.subkeys).to eq ['shell', 'system', 'mkdir', 'cd', 'cp', 'mv', 'rm', 'ln', 'chmod', 'chown', 'touch']
  end

  describe '#execute' do
    before(:each) do
      @command = MDT::Commands::Simple.new
    end
    it 'should not raise error' do
      expect { @command.execute('') }.not_to raise_error
    end
  end
end