require_relative '../../../../lib/mdt/command_modifiers/simple'

RSpec.describe MDT::CommandModifiers::Simple do
  it 'should have the "simple" key defined' do
    expect { MDT::CommandModifiers::Simple.key }.not_to raise_error
    expect(MDT::CommandModifiers::Simple.key).to eq('simple')
  end

  it 'should have "env", "sudo" and "generic" subkeys' do
    expect { MDT::CommandModifiers::Simple.subkeys }.not_to raise_error
    expect(MDT::CommandModifiers::Simple.subkeys).to eq(['env', 'sudo', 'generic'])
  end

  describe '#prepend' do
    before(:each) do
      @modifier = MDT::CommandModifiers::Simple.new
    end
    it 'should not raise error' do
      expect { @modifier.prepend('', '') }.not_to raise_error
    end
    it 'should define "env" command modifier that prepends an environment variable' do
      expect(@modifier.prepend('env', 'cmd', { name: 'ENV_VAR', value: 1 })).to eq 'ENV_VAR=1 cmd'
    end
    it 'should define "sudo" command modifier that prepends sudo command' do
      expect(@modifier.prepend('sudo', 'cmd', { args: '-testarg' })).to eq 'sudo -testarg cmd'
    end
    it 'should define "generic" command modifier that prepends given string' do
      expect(@modifier.prepend('generic', 'cmd', { modifier_str: 'test' })).to eq 'test cmd'
    end
  end
end