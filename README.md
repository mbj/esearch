elasticsearch
=============

[![Build Status](https://secure.travis-ci.org/mbj/elasticsearch.png?branch=master)](http://travis-ci.org/mbj/elasticsearch)
[![Dependency Status](https://gemnasium.com/mbj/elasticsearch.png)](https://gemnasium.com/mbj/elasticsearch)
[![Code Climate](https://codeclimate.com/github/mbj/elasticsearch.png)](https://codeclimate.com/github/mbj/elasticsearch)

Terminate the [elasticsearch API](http://www.elasticsearch.org/guide/reference/api/) in a friendly ruby PORO api.

Using AQL
---------

There is currently no stable public API.

Installation
------------

There is currently no gem release. Use git source in your Gemfile:

```ruby
# Unreleased support library
gem 'composition', :git => 'https://github.com/mbj/composition'
# The actual lib
gem 'elasticsearch', :git => 'https://github.com/mbj/elasticsearch'
```

Or use ```:github => 'mbj/elasticsearch'``` if you prefer unencrypted protocols.

Examples
--------

This gem does currently not have a public API. See specs if you are interested.

Credits
-------

* [Markus Schirp (mbj)](https://github.com/mbj) Author

Contributing
-------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile or version
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

License
-------

This gem is published under the MIT license. See LICENSE file.
