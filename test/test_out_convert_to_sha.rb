require_relative 'helper'

class ConvertToShaTest < Test::Unit::TestCase

  def setup
    Fluent::Test.setup
  end

  CONFIG_256 = %[
    sha  256
    salt hoge
    key  uid
  ]

  CONFIG_384 = %[
    sha  384
    salt hoge
    key  uid
  ]

  CONFIG_512 = %[
    sha  512
    salt hoge
    key  uid
  ]

  def create_driver(conf = CONFIG, tag = 'test')
    Fluent::Test::OutputTestDriver.new(Fluent::ConvertToSha, tag).configure(conf)
  end

  def test_convert_to_sha256
    d1 = create_driver(CONFIG_256, 'mako.mankanshoku')

    d1.run do
      d1.emit({"uid" => "10000", "nick" => "satsuki"})
      d1.emit({"uid" => "12345", "nick" => "senketsu"})
      d1.emit({"uid" => "33333", "nick" => "gamagori"})
    end

    emits = d1.emits

    # uid is 10000
    p emits[0]
    assert_equal "mako.mankanshoku", emits[0][0]
    assert_equal Digest::SHA256.hexdigest("hoge10000"), emits[0][2]["uid"]

    # uid is 12345
    p emits[1]
    assert_equal "mako.mankanshoku", emits[1][0]
    assert_equal Digest::SHA256.hexdigest("hoge12345"), emits[1][2]["uid"]

    # uid is 33333
    p emits[2]
    assert_equal "mako.mankanshoku", emits[2][0]
    assert_equal Digest::SHA256.hexdigest("hoge33333"), emits[2][2]["uid"]

  end

  def test_convert_to_sha384
    d1 = create_driver(CONFIG_384, 'mako.mankanshoku')

    d1.run do
      d1.emit({"uid" => "10000", "nick" => "satsuki"})
      d1.emit({"uid" => "12345", "nick" => "senketsu"})
      d1.emit({"uid" => "33333", "nick" => "gamagori"})
    end

    emits = d1.emits

    # uid is 10000
    p emits[0]
    assert_equal "mako.mankanshoku", emits[0][0]
    assert_equal Digest::SHA384.hexdigest("hoge10000"), emits[0][2]["uid"]

    # uid is 12345
    p emits[1]
    assert_equal "mako.mankanshoku", emits[1][0]
    assert_equal Digest::SHA384.hexdigest("hoge12345"), emits[1][2]["uid"]

    # uid is 33333
    p emits[2]
    assert_equal "mako.mankanshoku", emits[2][0]
    assert_equal Digest::SHA384.hexdigest("hoge33333"), emits[2][2]["uid"]

  end

  def test_convert_to_sha512
    d1 = create_driver(CONFIG_512, 'mako.mankanshoku')

    d1.run do
      d1.emit({"uid" => "10000", "nick" => "satsuki"})
      d1.emit({"uid" => "12345", "nick" => "senketsu"})
      d1.emit({"uid" => "33333", "nick" => "gamagori"})
    end

    emits = d1.emits

    # uid is 10000
    p emits[0]
    assert_equal "mako.mankanshoku", emits[0][0]
    assert_equal Digest::SHA512.hexdigest("hoge10000"), emits[0][2]["uid"]

    # uid is 12345
    p emits[1]
    assert_equal "mako.mankanshoku", emits[1][0]
    assert_equal Digest::SHA512.hexdigest("hoge12345"), emits[1][2]["uid"]

    # uid is 33333
    p emits[2]
    assert_equal "mako.mankanshoku", emits[2][0]
    assert_equal Digest::SHA512.hexdigest("hoge33333"), emits[2][2]["uid"]

  end

end
