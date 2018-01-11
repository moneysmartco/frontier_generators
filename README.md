# MoneySmart Generators

Use the MoneySmart Generators on the [Moneysmart App Cutter](https://github.com/moneysmartco/ms_app_cutter) and [Engine Cutter](https://github.com/moneysmartco/ms-engine-cutter) to quickly spin up CRUD interfaces.
For a simpler summary please see [Manager Readme](https://github.com/moneysmartco/moneysmart_generators/MANAGER_README.md)

By default, you get:
- Models with validations
- Factories for models using [FFaker](https://github.com/ffaker/ffaker). Factoried attributes take validations into account.
- Index, new, edit, destroy actions (note: no show action)
- Authorization via [Pundit](https://github.com/elabs/pundit) policies
- Feature and unit tests for all of the above
- Empty seed rake task
- Landing pages
- Acting as MsCore::Product
- Decorators (with unique decorator of objects acting as MsCore::Product)

## Important Caveat: In Progress

This gem is a work in progress. If you find a deficiency, add an issue.

Here is a list of some missing useful functionality:

- Support for sorting via Ransack
- Support for searching via Ransack
- Support for has_many associations
- Support for has_and_belongs_to_many associations
- Support for translations with globalize
- Date and DateTime validations
- Spec support for Date and DateTime fields
- Spec support for enum fields

## Important Caveat: Pairing with Engine Cutter

This gem is specifically made to be paired with the [Moneysmart App Cutter](https://github.com/moneysmartco/ms_app_cutter) and [Engine Cutter](https://github.com/moneysmartco/ms-engine-cutter)

If you want to use this gem in another rails project, you'd need to rewrite some of the output of the generators.

## Installing

Add the following to the development group in your Gemfile:

`gem 'moneysmart_generators', git: "moneysmartco/moneysmart_generators"`

## Basic Usage

You can create a YAML specification of your entities that you can pass directly to any of the generators. EG:

```
rails g frontier_scaffold /path/to/yml
```

## Model Options

You can define a model with some options as follows:

```yaml
model_name:
  # Use CanCanCan instead of Pundit (`pundit` by default)
  authorization: cancancan
  # Set if object is acting as a MsCore Product. `false` by default.
  acting_as: true
  # Do not generate factory. `false` by default.
  skip_factory: true
  # Do not generate model. `false` by default.
  skip_model: true
  # Do not generate policies. `false` by default.
  skip_policies: true
  # Do not generate a blank seed rake task for this model. `false` by default.
  skip_seeds: true
  # Do not create controller, routes, views, or specs for the above. `false` by default.
  skip_ui: true
  # Or skip specific controllers, views and specs
  skip_ui: [create, index, update, delete]
  # Adds support to soft delete for this model (acts_as_paranoid). `true` by default
  soft_delete: true
  # Do not generate a landing page. `true` by default.
  skip_landing_page: false
  # Set if object is for an engine. `false` by default.
  engine_object: true
  # Namespace inside Engine name.
  engine_name: 'personal_loans'
```

## Namespaces and nested routes

You can specify a set of namespaces or a collection of models that your generated controller will be nested under using the `controller_prefixes` option.

NOTE: Support for nested resources is a WIP.

Missing features:
- routes

```yaml
model_name:
  # Example: A single namespace
  #
  # Controller: Admin::ModelNamesController
  # Route:      admin_model_names_path (admin/model_names)
  # Views:      views/admin/model_names
  controller_prefixes: ['admin']

  # Example: A single nested resource
  #
  # Controller: Client::ModelNamesController
  # Route:      client_model_names_path(@client) (client/:id/model_names)
  # Views:      views/client/model_names
  controller_prefixes: [@client]

  # Example: A namespace and a nested resource
  #
  # Controller: Admin::Client::ModelNamesController
  # Route:      admin_client_model_names_path(@client) (admin/client/:id/model_names)
  # Views:      views/admin/client/model_names
  controller_prefixes: ['admin', @client]
```

## Attributes

You can specify which attributes should be on your model thusly:

```yaml
model_name:
  attributes:
    attribute_name:
      # Set primary to true if you want this attribute to be used for #to_s and for
      # checks in the feature specs. Chooses first attribute by default.
      primary: true
      # Set to false if you don't want this attribute to be represented on the index
      # Note: This is true by default
      show_on_index: false
      # Set to false to prevent this attribute being used in the form
      # Note: this is true by default
      show_on_form: false
      # Add in support for sorting on this attribute using Ransack.
      sortable: true

      # Choose one of the following
      type: boolean
      type: datetime
      type: date
      type: decimal
      type: integer
      type: string
      type: text

      # enum should also provide enum_options
      type: enum
      enum_options: ['admin', 'public']
```

NOTE: Support for the `sortable` attribute is partially implemented. It is currently missing implementation for nested resources.

## Associations

You can add associations the same way you would add an attribute. Currently supported:

EG:

```yaml
model_name:
  attributes:
    attribute_name:
      # Optional - this will use this model in factories and in the model
      class_name: "User"
      # One of inline or select
      form_type: "inline"
      attributes:
        # This should be a collection similar to the above. Show all the attributes and their type that you want to show in the inline form
      type: "belongs_to"
```

## Validations

You can add validations to your models. This will provide implementations and specs when generated.

Frontier currently supports the following validations:

```yaml
model_name:
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

## Views

By default, FG will generate views that fit with the look and feel of the Rails Template.

You can override the view templates that are used to generate the index, new, edit, and form pages by specifying a path to these templates:

```yaml
model_name:
  view_paths:
    index: "config/frontier_generators/views/index.html.haml"
    new: "config/frontier_generators/views/new.html.haml"
    edit: "config/frontier_generators/views/edit.html.haml"
    form: "config/frontier_generators/views/form.html.haml"
```

You should look at how these templates are generated by FG to get an idea of how you can override them.
