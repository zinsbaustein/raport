require 'spec_helper'
require 'raport/configuration'

RSpec.describe Raport::Configuration do
  
  let(:config) { described_class.new }

  describe '#storage' do
    context 'when storage is set through setter' do
      subject(:resource) do 
        config.storage = :fog
        config
      end
      it 'returns the setted storage' do
        expect(resource.storage).to eq :fog
      end
    end
    
    context 'when storage is not set' do
      it 'returns the default storage' do
        expect(config.storage).to eq :file
      end
    end
  end
end
