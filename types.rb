require 'dry-schema'

module Types
  # useful predicates https://dry-rb.org/gems/dry-schema/1.5/basics/built-in-predicates/
  include Dry.Types(default: :nominal)

  # Validators for converting pre-schema tests
  BoundedNumber = Instance(Numeric).constrained(gteq: 0)

  OutOfBoundsString = String.constrained(included_in: ['min', 'max'])

  # Dry::Types is a sissy. It won't work if OutOfBoundsString
  # is the last term.
  BoundedValue = OutOfBoundsString | BoundedNumber
end