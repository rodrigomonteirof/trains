require 'spec_helper'

describe DijkstraRouter do
  describe '.find_path' do
    subject { router.find_path(origin, destiny) }

    let(:router) { DijkstraRouter.new(map) }
    let(:map)    { Map.new([]) }
    let(:origin)  { 'A' }
    let(:destiny) { 'B' }

    let(:ab) { Route.new('A', 'B', 5) }
    let(:bc) { Route.new('B', 'C', 4) }
    let(:cd) { Route.new('C', 'D', 8) }
    let(:dc) { Route.new('D', 'C', 8) }
    let(:de) { Route.new('D', 'E', 6) }
    let(:ad) { Route.new('A', 'D', 5) }
    let(:ce) { Route.new('C', 'E', 2) }
    let(:eb) { Route.new('E', 'B', 3) }
    let(:ae) { Route.new('A', 'E', 7) }

    context 'when dont have any route' do
      it { is_expected.to eq('NO SUCH ROUTE') }
    end

    context 'when have one route' do
      before do
        map.routes = [ab]
      end

      it 'get shortest path' do
        is_expected.to eq(ab)
      end
    end

    context 'when have two routes with same origin' do
      before do
        map.routes = [ab, ae]
      end

      it 'get shortest path' do
        is_expected.to eq(ab)
      end
    end

    context 'when has a shortest path without children' do
      let(:destiny) { 'E' }

      let(:ac) { Route.new('A', 'C', 1) }

      before do
        map.routes = [ad, de, ac]
      end

      it 'get shortest path orgin' do
        expect(subject.distance).to eq(11)
      end
    end

    context 'prevent loop is true' do
      let(:da) { Route.new('A', 'B', 1) }
      let(:destiny) { 'E' }

      context 'when has a route with loop' do

        before do
          map.routes = [ad, de, da]
        end

        it 'delete the loop and go ahead' do
          expect(subject.distance).to eq(11)
        end
      end

      context 'when has only a loop route' do
        before do
          map.routes = [ad, da]
        end

        it { is_expected.to eq('NO SUCH ROUTE') }
      end
    end

    context 'prevent_loop is false' do
      subject { router.find_path('C', 'C', false) }

      before do
        map.routes = [cd, dc]
      end

      it 'get shortest path' do
        expect(subject.distance).to eq(16)
      end
    end
  end
end
