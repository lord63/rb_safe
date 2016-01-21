require 'rb_safe/constant'
require 'rb_safe/words'

module RbSafe
  def self.asdf?(raw)
    # The current implementation treat those passwords that in the same line
    # are "is asdf".
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
      @valid
    end

    def to_str
      @strength
    end

    def to_s
      @message
    end
  end

  def self.check(raw, length = 8, freq = 0, min_types = 3, level = STRONG)
    level = STRONG if level > STRONG
    raw = raw.to_s
    if raw.length < length
      return Strength.new(false, 'terrible', 'password is too short')
    elsif asdf?(raw) || by_step?(raw)
      return Strength.new(false, 'simple', 'password has a pattern')
    elsif common_password?(raw, freq)
      return Strength.new(false, 'simple', 'password is too common')
    end
    types = 0
    types += types if raw =~ /[a-z]/ # Has lower letter.
    types += types if raw =~ /[A-Z]/ # Has upper letter.
    types += types if raw =~ /[0-9]/ # Has number.
    types += types if raw =~ /[^0-9a-zA-Z]/ # Has mark.
    if types < 2
      return Strength.new(level <= SIMPLE, 'simple', 'password is too simple')
    elsif types < min_types
      return Strength.new(level <= MEDIUM, 'medium',
                          'password is good enough, but not strong')
    else
      return Strength.new(true, 'strong', 'password is perfect')
    end
  end
end
