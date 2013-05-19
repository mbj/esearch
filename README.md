esearch
=======

[![Build Status](https://secure.travis-ci.org/mbj/esearch.png?branch=master)](http://travis-ci.org/mbj/esearch)
[![Dependency Status](https://gemnasium.com/mbj/esearch.png)](https://gemnasium.com/mbj/esearch)
[![Code Climate](https://codeclimate.com/github/mbj/esearch.png)](https://codeclimate.com/github/mbj/esearch)

Terminate the [esearch API](http://www.esearch.org/guide/reference/api/) in a friendly ruby PORO api.

Installation
------------

Install the gem `esearch` via your preferred method.

Examples
--------

```ruby
# Settings suitable for operation on single node
settings = {
  :settings => {
    :number_of_shards => 1,
    :number_of_replicas => 0
  }
)

# Connect to a cluster
cluster = Esearch::Cluster.connect(uri, Logger.new($stderr, :debug)) }

# Create index 
index_a = cluster.index('test-a')
index_a.exist? # => false, does not exist jet
index_a.create(settings) 
index_a.exist? # => true

# Create another index
index_b = cluster.index('test-b')
index_b.create(SINGLE_NODE_SETTINGS)

# Wait for cluster initialization
cluster.health(:wait_for_status => :green, :timeout => '10s')

# Access many indexes at once
indices = cluster.indices(%w(test-a test-b))

# Index some data
result_a = index_a.type('type-a').index({'foo' => 'bar'})
result_b = index_b.type('type-b').index({'foo' => 'baz'})

# Refresh indices
indices.refresh

# Query all documents in index a
result = index_a.search({:query => { :match_all => {}}})
result.hits.map(&:source) # => [{'foo' => 'bar'}]

# Query all documents across two indexes
result = indices.search({:query => { :match_all => {}}})
result.hits.map(&:source) # => [{'foo' => 'bar'}, {'foo' => 'baz'}]

# Delete a document
index_a.type('type-a').document(result_a.id).delete

# Query a document by id
document = index_b.type('type-b').document(result_b.id).get
document.source # => {'foo' => 'baz'}
```

Compatibility
-------------

Tested under {mri,jruby,rbx} > 1.8.

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
