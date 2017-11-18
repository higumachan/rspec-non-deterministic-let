# Rspec::NonDeterministicLet

The aim of this gem is easy and intuitive writing with multi precondition specs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-non-deterministic-let'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-non-deterministic-let

## Usage

### How to use your project

#### Rails

Please add spec/rails_helper.rb

```ruby
require 'rspec/non_deterministic_ret'
```

#### Other

Please add spec/spec_helper.rb

```ruby
require 'rspec/non_deterministic_ret'
```

### Simple case

You can write that code in spec.

```ruby
RSpec.describe 'Some test'do
  nd_let(:some_state) { 1 }
  nd_let(:some_state) { 2 }

  nd_let_context :some_state do
    it 'some_state = 1 or 2' do
      expect(some_state).to be >= 1
      expect(some_state).to be <= 2
    end
    it 'some_state only 1 or 2' do
      expect(some_state).not_to be < 1
      expect(some_state).not_to be > 2
    end
  end
end
```

It is same as this code. (but context message is different)

```ruby
RSpec.describe 'Some test without this gem'do

  shared_examples 'some_state is 1 or 2' do
    it 'some_state = 1 or 2' do
      expect(some_state).to be >= 1
      expect(some_state).to be <= 2
    end
    it 'some_state only 1 or 2' do
      expect(some_state).not_to be < 1
      expect(some_state).not_to be > 2
    end
  end

  context 'some_state = 1' do
    let(:some_state) { 1 }
    include_examples 'some_state is 1 or 2' 
  end

  context 'some_state = 2' do
    let(:some_state) { 2 }
    include_examples 'some_state is 1 or 2' 
  end
end
```

I think that before one is more intuitive.

`spec/rspec/examples_spec.rb` contain these examples.

### Description

If you want to description with `nd_let` then you can set description using by second argument.

```
RSpec.describe 'Some test use by description' do
  nd_let(:some_state, 'some_state = 1') { 1 }
  nd_let(:some_state, 'some_state = 2') { 2 }

  nd_let_context :some_state do
    it 'some_state = 1 or 2' do
      expect(some_state).to be >= 1
      expect(some_state).to be <= 2
    end
    it 'some_state only 1 or 2' do
      expect(some_state).not_to be < 1
      expect(some_state).not_to be > 2
    end
  end
end
```

This example is exactry same as `Some test without this gem` case.


### nd_let!

You can use `nd_let!`.
The effect of 'nd_let!' is same as `let!` for `let`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rspec-non-deterministic-let. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rspec::Non::Deterministic::Let project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rspec-non-deterministic-let/blob/master/CODE_OF_CONDUCT.md).
