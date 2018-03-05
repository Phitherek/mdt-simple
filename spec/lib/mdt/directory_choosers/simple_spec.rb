require_relative '../../../../lib/mdt/directory_choosers/simple'

RSpec.describe MDT::DirectoryChoosers::Simple do
  it 'should have the "simple" key defined' do
    expect { MDT::DirectoryChoosers::Simple.key }.not_to raise_error
    expect(MDT::DirectoryChoosers::Simple.key).to eq('simple')
  end

  it 'should have "directory" subkey' do
    expect { MDT::DirectoryChoosers::Simple.subkeys }.not_to raise_error
    expect(MDT::DirectoryChoosers::Simple.subkeys).to eq ['directory']
  end

  describe '#mkdir' do
    before(:each) do
      @directory_choosers = MDT::DirectoryChoosers::Simple.new
    end
    it 'should not raise error' do
      expect { @directory_choosers.mkdir('') }.not_to raise_error
    end
  end

  describe '#cd' do
    before(:each) do
      @directory_choosers = MDT::DirectoryChoosers::Simple.new
    end
    it 'should not raise error' do
      expect { @directory_choosers.cd('') }.not_to raise_error
    end
  end

  describe '#rm' do
    before(:each) do
      @directory_choosers = MDT::DirectoryChoosers::Simple.new
    end
    it 'should not raise error' do
      expect { @directory_choosers.rm('') }.not_to raise_error
    end
  end
end