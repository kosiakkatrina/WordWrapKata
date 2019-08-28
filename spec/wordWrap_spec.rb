class Wrapper
  def self.wrap (s,c)
    raise ArgumentError if (c < 1 || c%1!=0)
    s = s.to_s
    s = s.strip
    if s.length > c
      where_to_break = s.slice(0, c).rindex(" ") || c
      num_characters_remain = s.length - where_to_break
      return s.slice(0, where_to_break) + "\n" + wrap(s.slice(where_to_break, num_characters_remain).strip, c)
    end
    s
  end
end



describe Wrapper do
  it "returns an empty string when given an empty string" do
    expect(Wrapper.wrap('', 4)).to eq('')
  end

  it "returns the string when string length is less than column" do
    expect(Wrapper.wrap('word',6)).to eq('word')
  end

  it "converts input into string" do
    expect(Wrapper.wrap(nil, 5)).to eq('')
    expect(Wrapper.wrap(2432, 5)).to eq('2432')
  end

  it "raises ArgumentError when given invalid column input" do
    expect { Wrapper.wrap('word', -5) }.to raise_error(ArgumentError)
    expect { Wrapper.wrap('word', 0) }.to raise_error(ArgumentError)
    expect { Wrapper.wrap('word', 2.5) }.to raise_error(ArgumentError)
    expect { Wrapper.wrap('word', '5') }.to raise_error(ArgumentError)
  end

  it "returns split string" do
    expect(Wrapper.wrap('longword', 4)).to eq("long\nword")
    expect(Wrapper.wrap('longerword', 6)).to eq("longer\nword")
    expect(Wrapper.wrap('verylongword', 4)).to eq("very\nlong\nword")
  end

  it "splits strings on spaces" do
    expect(Wrapper.wrap('long word', 4)).to eq("long\nword")
    expect(Wrapper.wrap(' long word ', 4)).to eq("long\nword")
    expect(Wrapper.wrap('long word ', 5)).to eq("long\nword")
    expect(Wrapper.wrap('     ', 1)).to eq("")

  end

  it "breaks lines at word boundaries" do
    expect(Wrapper.wrap('long word', 6)).to eq("long\nword")
  end

  it "does long text" do
    expect(Wrapper.wrap("You write a class called Wrapper, that has a single static function named wrap that takes two arguments, a string, and a column number. The function returns the string, but with line breaks inserted at just the right places to make sure that no line is longer than the column number. You try to break lines at word boundaries.", 66)).to eq("You write a class called Wrapper, that has a single static\nfunction named wrap that takes two arguments, a string, and a\ncolumn number. The function returns the string, but with line\nbreaks inserted at just the right places to make sure that no\nline is longer than the column number. You try to break lines at\nword boundaries.")
  end
end
