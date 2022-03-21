require 'dry-schema'
require 'byebug'

require_relative '../types'

RSpec.describe 'foo' do
  before do
    include Types

    BadQuality = Dry::Schema.Params do
      required(:sample_quality).value(eql?: 3)
    end

    Psa = Dry::Schema.Params do
      required(:psa).value(Types::BoundedValue) { str? | gteq?(0.5) & lteq?(150.0) }
    end
  end

  it 'does something' do
    schema = Dry::Schema.Params do required(:lab_code).hash(BadQuality | Psa) end
    expect(schema.call('lab_code' => { psa: "invalid" }).errors).to eq(true)
  end
end