require 'rb_safe/constant'
require 'rb_safe/words'

module RbSafe
  def self.asdf?(raw)
    # The current implementation treats those passwords that in the same line
    # are "is asdf", e.g. 'qwer' is, 'opas' not.
    keyboard = %w(qwertyuiop, asdfghjkl, zxcvbnm)
    keyboard.any? do |pattern|
      pattern.include?(raw) || pattern.include?(raw.reverse)
    end
  end

  def self.by_step?(raw)
    delta = raw[1].ord - raw[0].ord
    2.upto(raw.length - 1) do |index|
      return false if raw[index].ord - raw[index - 1].ord != delta
    end
    true
  end

  def self.common_password?(raw, freq = 0)
    frequent = Words.new.common_passwords.fetch(raw, 0)
    if !freq.zero?
      frequent > freq
    else
      !frequent.zero?
    end
  end

  class Strength
    attr_reader :valid, :strength, :message
    def initialize(valid, strength, message)
      @valid = valid
      @strength = strength
      @message = message
    end

    def bool
    # TODO: take a look at this method, maybe choose another name.
      @valid
    end

    def inspect
      @strength
    end

    def to_s
      @message
    end
  end

  def self.check(raw, config={})
    default_config = {length: 8, freq: 0, min_types: 3, level: STRONG}
    config = default_config.update(config)

    level = STRONG if config[:level] > STRONG
    raw = raw.to_s
    if raw.length < config[:length]
      return Strength.new(false, 'terrible', 'password is too short')
    elsif asdf?(raw) || by_step?(raw)
      return Strength.new(false, 'simple', 'password has a pattern')
    elsif common_password?(raw, config[:freq])
      return Strength.new(false, 'simple', 'password is too common')
    end
    types = 0
    types += 1 if raw =~ /[a-z]/ # Has lower letter.
    types += 1 if raw =~ /[A-Z]/ # Has upper letter.
    types += 1 if raw =~ /[0-9]/ # Has number.
    types += 1 if raw =~ /[^0-9a-zA-Z]/ # Has mark.
    if types < 2
      return Strength.new(config[:level] <= SIMPLE, 'simple',
                          'password is too simple')
    elsif types < config[:min_types]
      return Strength.new(config[:level] <= MEDIUM, 'medium',
                          'password is good enough, but not strong')
    else
      return Strength.new(true, 'strong', 'password is perfect')
    end
  end
end
