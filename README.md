# fluent convert value to sha plugin.

This plugin is purpose value convert to sha256/384/512.

## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-convert-value-to-sha'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-convert-value-to-sha

## How to use

- create fluentd config file

```
<source>
  type forward
  port 24224
</source>

<match mako>
  type convert_to_sha
  sha  256
  salt uge
  key  id
</match>

<match sha>
  type file
  path ./test.log
</match>
```

- send test data

```
echo '{"id": "hoge"}' | fluent-cat mako
```

- result (test.log)

```
2013-11-01T20:38:20+09:00       sha     {"id":"cc6191550d712d0b506558ff7c6c0e2b6563e3f6f84a85d65ebf994bb0d23715"}
```

## Copyright

Copyright (c) 2013 Aiming Inc.

## License

MIT.
