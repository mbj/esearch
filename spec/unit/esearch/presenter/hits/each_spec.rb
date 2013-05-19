require 'spec_helper'

describe Esearch::Presenter::Hits, '#each' do
  subject { object.each { |hit| yields << hit } }

  let(:object) { described_class.new(raw) }
  let(:yields) { [] }
  let(:hit_a) { mock('Hit A') }
  let(:hit_b) { mock('Hit B') }
  let(:raw)    { { 'hits' => [ hit_a, hit_b ] } }

  it_should_behave_like 'an #each method'

  its(:to_a) { should eql([Esearch::Presenter::Hit.new(hit_a), Esearch::Presenter::Hit.new(hit_b)]) }
end
