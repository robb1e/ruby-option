class Option

  def initialize(value)
    @values = Array(value)
  end

  def each
    @values.each { |e| yield(e) }
  end

  def fetch(&block)
    @values.first || block.call if block
  end

  def map(&block)
    Option(@values.map { |e| block.call(e) }.first)
  end

  def select(&block)
    Option(@values.select { |e| block.call(e) }.first)
  end

  def method_missing(method, *arguments, &block)
  	result = @values.send method, &block
  	Option(result)
  end

end

def Option(value)
  Option.new(value)
end

p Option(" foo ").map { |f| f.strip }.fetch { "hello" }
p Option(nil).map { |f| f.strip }.select { |f| f.length > 0 }.map { |f| f.upcase }.fetch # strange exception
p Option(nil).map { |f| f.strip }.select { |f| f.length > 0 }.map { |f| f.upcase }.fetch { "hello"}
p Option(" foo ").map { |f| f.strip }.select { |f| f.length > 0 }.map { |f| f.upcase }
p Option(" foo ").find { |f| f == " foo " }


