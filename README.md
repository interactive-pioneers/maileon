# Maileon [![Build Status](http://travis-ci.org/interactive-pioneers/maileon.svg?branch=master)](https://travis-ci.org/interactive-pioneers/maileon) [![Gem Version](https://badge.fury.io/rb/maileon.svg)](http://badge.fury.io/rb/maileon) [![Coverage Status](https://coveralls.io/repos/interactive-pioneers/maileon/badge.svg)](https://coveralls.io/r/interactive-pioneers/maileon)

Ruby wrapper for Maileon email marketing software API.

- Supported Ruby versions:
  - 2.2.1 (strongly recommended)
  - 2.1.0
  - 2.0.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'maileon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install maileon

## Usage

Below API requests are currently supported by the gem:

### Ping

``` ruby
api_key = "e30994fg0fig6t049u42j3gblgsr59043"
maileon = Maileon::API.new(api_key, true)
maileon.ping
```

### Subscribe

``` ruby
api_key = "e30994fg0fig6t049u42j3gblgsr59043"
maileon = Maileon::API.new(api_key, true)
attribs = {
  :email => "subscriber@email.com"
}
body = {
  :email => "subscriber@email.com",
  :custom_fields => {
    :CUSTOM_FIELD_DEFINED_AT_MAILEON => "1"
  },
  :standard_fields => {
    :SALUTATION => "Herr",
    :GENDER => "m",
    :FIRSTNAME => "Max",
    :LASTNAME => "Mustermann",
    :LOCALE => "de_DE",
    :CITY => "Hamburg",
    :COUNTRY => "Germany",
    :ZIP => "22675",
    :ADDRESS => "Friedensallee",
    :HNR => "9"
  }
}
maileon.create_contact(attribs, body)
```

### Unsubscribe

``` ruby
api_key = "e30994fg0fig6t049u42j3gblgsr59043"
maileon = Maileon::API.new(api_key, true)
attribs = {
  :email => "subscriber@email.com"
}
maileon.delete_contact(attribs)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/maileon/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Develop your feature by concepts of test-driven development. Run `guard` in parallel to automatically run your tests
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request