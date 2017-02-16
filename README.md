![alt text](https://d21buns5ku92am.cloudfront.net/59399/images/195128-FL_Logo.4c_pos-9e9519-medium-1455014952.png "Logo Finleap GmbH")

Raport beta
===========

[![Build Status](https://img.shields.io/travis/HitFox/raport.svg?style=flat-square)](https://travis-ci.org/HitFox/raport)
[![Gem](https://img.shields.io/gem/dt/raport.svg?style=flat-square)](https://rubygems.org/gems/raport)
[![Code Climate](https://img.shields.io/codeclimate/github/HitFox/raport.svg?style=flat-square)](https://codeclimate.com/github/HitFox/raport)
[![Coverage](https://img.shields.io/coveralls/HitFox/raport.svg?style=flat-square)](https://coveralls.io/github/HitFox/raport)

Description
-----------

Create large data reports within your rails app, without influencing the performance of the app server.
​
Usage
------------


Installation
------------

If you user bundler, then just add 
```ruby
gem 'raport'
```
to your Gemfile and execute
```
$ bundle install
```
or without bundler
```
$ gem install raport
```

After intalling the gem, please run the config generator:

```
$ rails generate raport:config
```

Upgrade
-------
```
$ bundle update raport
```
or without bundler

```
$ gem update raport
```
​
Changelog
---------

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/HitFox/raport. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
