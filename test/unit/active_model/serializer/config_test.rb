require 'test_helper'

module ActiveModel
  class Serializer
    class Config
      class Test < ActiveModel::TestCase
        def test_config_const_is_an_instance_of_config
          assert_kind_of Config, CONFIG
        end

        def test_config_instance
          config = Config.new
          config.setting1 = 'value1'

          assert_equal 'value1', config.setting1
        end

        def test_each_config
          config = Config.new
          config.setting1 = 'value1'
          config.setting2 = 'value2'

          actual = {}

          config.each do |k, v|
            actual[k] = v
          end

          assert_equal({ 'setting1' => 'value1', 'setting2' => 'value2' }, actual)
        end
      end

      class SetupTest < ActiveModel::TestCase
        def test_setup
          ActiveModel::Serializer.setup do |config|
            config.a = 'v1'
            config.b = 'v2'
          end

          assert_equal 'v1', CONFIG.a
          assert_equal 'v2', CONFIG.b
        ensure
          CONFIG.clear
        end

        def test_setup_config_accessors
          ActiveModel::Serializer.setup do |config|
            config.foo = 'v1'
            config.bar = 'v2'
          end

          assert_equal 'v1', CONFIG.foo
          assert_equal 'v2', CONFIG.bar
        ensure
          CONFIG.clear
        end

        def test_setup_acessor_when_nil
          assert_nil CONFIG.foo
          CONFIG.foo = 1
          assert_equal 1, CONFIG.foo
          assert_nil CONFIG.bar
        end
      end
    end
  end
end
