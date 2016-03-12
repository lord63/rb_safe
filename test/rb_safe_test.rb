require 'test_helper'

class RbSafeTest < Minitest::Test
  def setup
    cache_name = "rb_safe-#{RbSafe::VERSION}.words.cache"
    cache_file = ENV.fetch('RUBY_SAFE_WORDS_CACHE',
                           "#{Dir.tmpdir}/#{cache_name}")
    if File.exists?(cache_file)
      File.delete(cache_file)
    end
  end

  def test_that_it_has_a_version_number
    refute_nil ::RbSafe::VERSION
  end

  def test_asdf_password
    is_asdf = RbSafe.check('asdfghjk')
    assert is_asdf.message.include?('pattern')
    not_asdf = RbSafe.check('asdfhjkl')
    assert !not_asdf.message.include?('pattern')
  end

  def test_by_step_password
    is_by_step = RbSafe.check('abcdefgh')
    assert is_by_step.message.include?('pattern')
    not_by_step = RbSafe.check('abcdfghi')
    assert !not_by_step.message.include?('pattern')
  end

  def test_common_password
    common_password = RbSafe.check('password')
    assert common_password.message.include?('common')
  end

  def test_common_password_with_freq
    common_password = RbSafe.check('password', {freq: 1})
    assert common_password.message.include?('common')
  end

  def test_terrible_password
    terrible_password = RbSafe.check(1)
    assert_equal(terrible_password.strength, 'terrible')
  end

  def test_simple_password
    simple_password = RbSafe.check('issafepassword')
    assert_equal(simple_password.strength, 'simple')
  end

  def test_medium_password
    medium_password = RbSafe.check('is.safe.password')
    assert_equal(medium_password.strength, 'medium')
  end

  def test_strong_password
    strong_password = RbSafe.check('is.safe.passw0rd?')
    assert_equal(strong_password.strength, 'strong')
  end

  def test_strength
    strength = RbSafe::Strength.new(true, 'strong', 'perfect')
    assert_equal(strength.bool, true)
    assert_equal(strength.inspect, 'strong')
    assert_equal(strength.to_s, 'perfect')
  end

  def test_load_words_from_cache
    password = RbSafe.check('password')
    assert_equal(password.strength, 'simple')
    RbSafe::Words.new.common_passwords
    another_password = RbSafe.check('password')
    assert_equal(another_password.strength, 'simple')
  end
end
