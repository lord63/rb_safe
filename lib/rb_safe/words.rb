module RbSafe
  class Words
    def common_passwords
      load_words
    end

    private

    def load_words
      cache_name = "rb_safe-#{VERSION}.words.cache"
      cache_file = ENV.fetch('RUBY_SAFE_WORDS_CACHE',
                             "#{Dir.tmpdir}/#{cache_name}")
      # Load from cache if it exists.
      if File.exist?(cache_file)
        # TODO: deal with the exception.
        # File.open(cache_file, 'rb') do |file|
        return Marshal.load(File.open(cache_file, 'rb'))
        # end
      end

      # Convert the data to a hash.
      words_file = ENV.fetch(
        'RUBY_SAFE_WORDS_FILE',
        "#{File.dirname(File.realdirpath(__FILE__))}/words.dat")
      words = {}
      File.open(words_file, 'rb') do |file|
        file.readlines.each do |line|
          name, freq = line.split
          words[name] = freq.to_i
        end
      end

      # Cache the words.
      File.open(cache_file, 'wb') do |file|
        Marshal.dump(words, file)
      end

      words
    end
  end
end
