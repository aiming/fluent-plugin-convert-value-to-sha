# coding: utf-8
#

require 'digest/sha2'

DIGEST = {
  "256" => Digest::SHA256,
  "384" => Digest::SHA384,
  "512" => Digest::SHA512
}

class Fluent::ConvertToSha < Fluent::Output
  Fluent::Plugin.register_output('convert_to_sha', self)

  config_param :sha, :string, :default => '256'
  config_param :salt, :string, :default => 'mako'
  config_param :key, :string, :default => nil

  def configure(conf)
    super

    if @salt.strip.length == 0
      raise Fluent::ConfigError, "require salt"
    end

    if @sha.to_s == '1'
      raise Fluent::ConfigError, "sha1 algorithm is vulnerable."
    end

    if @key.nil?
      raise Fluent::ConfigError, "require key name."
    end

    @mutex = Mutex.new

  end

  def start
    super
  end

  def shutdown
    super
  end

  def emit(tag, es, chain)
    es.each do |time, record|
      Fluent::Engine.emit(tag, time, convert_to_sha(record))
    end

    chain.next
  end

  private
  def convert_to_sha(record)
    record[@key] = DIGEST[@sha].hexdigest(@salt + record[@key].to_s)
    return record
  end

end
