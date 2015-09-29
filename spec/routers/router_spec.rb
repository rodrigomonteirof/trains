require 'spec_helper'

describe Router do
  let(:router) { Router.new(map) }
  let(:map)    { Map.new([]) }

  let(:ab) { Route.new('A', 'B', 5) }
  let(:bc) { Route.new('A', 'C', 6) }

  describe '.shortest_route' do
    subject { router.shortest_route }

    context 'when dont have available routes' do
      it{ is_expected.to eq nil }
    end

    context 'when have one route' do
      before do
        router.available_routes = [ab]
      end

      it{ is_expected.to eq ab }
    end

    context 'when have two routes' do
      before do
        router.available_routes = [ab, bc]
      end

      it 'get shortest route' do
        is_expected.to eq(ab)
      end
    end
  end

  describe '.delete_route' do
    subject { router.delete_route(ab) }

    context 'when dont have available routes' do
      it{ is_expected.to eq nil }
    end

    context 'when have one route' do
      before do
        router.available_routes = [ab]
      end

      it 'delete the route' do
        subject

        expect(router.available_routes).to be_empty
      end
    end

    context 'when have two routes' do
      before do
        router.available_routes = [ab, bc]
      end

      it 'get shortest route' do
        subject
        expect(router.available_routes).to eq([bc])
      end
    end
  end

end
