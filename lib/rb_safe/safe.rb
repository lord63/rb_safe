module RbSafe
  class Safe
    def self.is_asdf(raw)
      # The current implementation treat those passwords that in the same line
      # are "is asdf".
      keyboard = ['qwertyuiop', 'asdfghjkl', 'zxcvbnm']
      keyboard.any? { |pattern| pattern.include?(raw) or
                      pattern.include?(raw.reverse) }
    end
  end
end
