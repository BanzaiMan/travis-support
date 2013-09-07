require 'spec_helper'
require 'travis/support'
require 'stringio'
require 'hashr'

describe Travis::Logger do
  let(:io)     { StringIO.new }
  let(:log)    { io.string }
  let(:logger) { Travis::Logger.new(io) }

  before :each do
    Travis.stubs(:config).returns(Hashr.new(log_level: :info))
  end

  describe '.log_level' do
    after :each do
      Travis.send(:remove_const, :Worker) if defined?(Travis::Worker)
    end

    it 'returns Travis::Worker.config.log_level if defined' do
      Travis.const_set(:Worker, Module.new)
      Travis::Worker.stubs(:config).returns(Hashr.new(log_level: :info))
      Travis::Logger.log_level.should == :info
    end

    it 'returns Travis.config.log_level if defined' do
      Travis::Logger.log_level.should == :info
    end

    it 'returns :debug by default' do
      Travis.stubs(:respond_to?).with(:config).returns(false)
      Travis::Logger.log_level.should == :debug
    end
  end
end

