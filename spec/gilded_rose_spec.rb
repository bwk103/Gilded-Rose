require 'gilded_rose'

describe GildedRose do

  let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 0, 80) }
  let(:brie) { Item.new('Aged Brie', 10, 10) }
  let(:passes) { Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 10) }

  describe '#update_quality' do
    describe 'Sulfuras, Hand of Ragnaros' do
      before(:each) do
        @items = [sulfuras]
        GildedRose.new(@items).update_quality()
      end
      it 'quality does not decrease' do
        expect(@items[0].quality).to eq 80
      end

      it 'sellIn does not decrease' do
        expect(@items[0].sell_in).to eq 0
      end
    end

    describe 'Aged Brie' do
      before(:each) do
        @items = [brie]
        GildedRose.new(@items).update_quality()
      end
      it 'quality increases by 1' do
        expect(@items[0].quality).to eq 11
      end
      it 'sellIn decreases by 1' do
        expect(@items[0].sell_in).to eq 9
      end
    end
  end
end
