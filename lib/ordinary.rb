class Ordinary
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def update_item(store)
    @quality -= 1
    @sell_in -= 1
    @quality -= 1 if @sell_in < 0
    store.checkMinQuality(self)
  end
end
