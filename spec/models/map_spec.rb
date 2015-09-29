require 'spec_helper'

describe Map do
  let(:map)    { Map.new([]) }

  let(:first)  { Route.new('A', 'B', 5) }
  let(:second) { Route.new('B', 'C', 4) }
  let(:routes) { [first, second] }


  describe '.find_routes' do
    subject { map.find_routes('A') }

    context 'when not have routes' do
      it { is_expected.to eq([]) }
    end

    context 'when have multiple routes' do
      before do
        map.routes = routes
      end

      it 'filter by origins' do
        is_expected.to eq([first])
      end
    end
  end

  describe '.find_route' do
    subject { map.find_route('A', 'B') }

    context 'when not have routes' do
      it { is_expected.to eq(nil) }
    end

    context 'when have multiple routes' do
      before do
        map.routes = routes
      end

      it 'filter by origins' do
        is_expected.to eq(first)
      end
    end
  end
end
