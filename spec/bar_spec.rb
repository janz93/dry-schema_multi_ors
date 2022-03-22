require 'dry-schema'
require 'byebug'


RSpec.describe 'foo' do
  before do
    IndividualSchema = Dry::Schema.JSON do
      required(:first_name).filled(:str?)
      required(:last_name).filled(:str?)
    end

    CompanySchema = Dry::Schema.JSON do
      required(:name).filled(:str?)
      required(:owner_name).filled(:str?)
    end

    AnonymousSchema = Dry::Schema.JSON do
      required(:country).filled(:str?)
    end
  end

  it 'does something' do
    schema =  Dry::Schema.Params do required(:details).schema(IndividualSchema | CompanySchema | AnonymousSchema) end
    expect(schema.call(details: { first_name: "John", last_name: "Doe" }).errors.count).to eq(0)
  end
end