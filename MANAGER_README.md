# MoneySmart Generators

These generators will cover the basic setup of objects for new projects.
They are useful for quickly generating objects and views with automatic
test coverage and implementation.

Things that can be created:

- New Models
- New Landing page
- New Admin sections
- Policy for new objects (Permissions)

All are written with complete implementation and tests for the implementation.
The work a developer would still need to work on is.

- Sorting
- The content of the landing page. (components etc)
- Translations
- Individual object show pages
- Associated objects (exists to a degree but not fool proof)

The following validations for a new field can be used.
EG: Values must always be between X and Y.
OR a field must always be present. or unique.
```
attributes:
    attribute_name:
      validates:
        inclusion: [1,2,3,4]
        length:
          minimum: 0
          maximum: 666
          is: 100
          # in and within are aliases for eachother
          in: 0..100
          within: 0..100
        numericality: true
        # Or, numericality can use one or more args
        numericality:
          allow_nil: true
          greater_than: 0
          greater_than_or_equal_to: 0
          equal_to: 0
          less_than: 100
          less_than_or_equal_to: 100
          only_integer: true
        presence: true
        uniqueness: true
        # Or, uniquenss can support the scope argument
        uniqueness:
          scope: user_id
```

