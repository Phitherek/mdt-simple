require_relative '../../../../lib/mdt/fetchers/simple'

RSpec.describe MDT::Fetchers::Simple do
  it 'should have the "simple" key defined' do
    expect { MDT::Fetchers::Simple.key }.not_to raise_error
    expect(MDT::Fetchers::Simple.key).to eq('simple')
  end

  it 'should have "directory" subkey' do
    expect { MDT::Fetchers::Simple.subkeys }.not_to raise_error
    expect(MDT::Fetchers::Simple.subkeys).to eq ['directory']
  end

  describe '#fetch' do
    before(:each) do
      @fetcher = MDT::Fetchers::Simple.new
    end
    it 'should not raise error' do
      expect { @fetcher.fetch('') }.not_to raise_error
    end
  end
end