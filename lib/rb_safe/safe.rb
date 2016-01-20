require 'rb_safe/constant'
require 'rb_safe/words'

module RbSafe
  def self.is_asdf(raw)
    # The current implementation treat those passwords that in the same line
    # are "is asdf".
    keyboard = ['qwertyuiop', 'asdfghjkl', 'zxcvbnm']
    keyboard.any? { |pattern| pattern.include?(raw) or
                    pattern.include?(raw.reverse) }
  end

  def self.is_by_step(raw)
    delta = raw[1].ord - raw[0].ord
    2.upto(raw.length-1) do |index|
      return false if raw[index].ord - raw[index-1].ord != delta
    end
    return true
  end

  def self.is_common_password(raw, freq=0)
    frequent = Words.new.common_passwords.fetch(raw, 0)
    if !freq.zero?
      frequent > freq
    else
      !frequent.zero?
    end
  end

  class Strength
  end
end
