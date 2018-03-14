require 'gilded_rose'

describe GildedRose do

  let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 0, 80) }
  let(:brie) { Item.new('Aged Brie', 10, 10) }
  let(:passes) { Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 10) }
  let(:ordinary) { Item.new('Ordinary item', 10, 10) }

  describe '#update_quality' do
    describe 'ordinary items' do
      it "quality cannot be negative" do
        @items = [ordinary]
        store = GildedRose.new(@items)
        11.times { store.update_quality }
        expect(@items[0].quality).to be 0
      end

      describe "before sell by date" do
        before(:each) do
          @items = [ordinary]
          GildedRose.new(@items).update_quality()
        end

        it "quality decreases by 1" do
          expect(@items[0].quality).to be 9
        end
        it "sellIn decreases by 1" do
          expect(@items[0].sell_in).to be 9
        end
      end

      describe "after sell by date" do
        before(:each) do
          ordinary = Item.new('Ordinary item', 0, 10)
          @items = [ordinary]
          GildedRose.new(@items).update_quality()
        end

        it "quality decreases by 2" do
          expect(@items[0].quality).to be 8
        end

        it "sellIn decreases by 1" do
          expect(@items[0].sell_in).to be -1
        end
      end
    end

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
        @store = GildedRose.new(@items)
        @store.update_quality
      end

      it 'quality increases by 1' do
        expect(@items[0].quality).to eq 11
      end

      it 'quality cannot be more than 50' do
        45.times { @store.update_quality }
        expect(@items[0].quality).to be 50
      end

      it 'sellIn decreases by 1' do
        expect(@items[0].sell_in).to eq 9
      end
    end

    describe 'Backstage passes to a TAFKAL80ETC concert' do
      before(:each) do
        @items = [passes]
        GildedRose.new(@items).update_quality()
      end

      it 'quality cannot be more than 50' do
        passes =  Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 50)
        @items = [passes]
        GildedRose.new(@items).update_quality
        expect(@items[0].quality).to be 50
      end
      
      describe "when more than 10 days before the concert" do
        it "quality increases by 1" do
          expect(@items[0].quality).to be 11
        end
        it "sellIn decreases by 1" do
          expect(@items[0].sell_in).to be 14
        end
      end
      describe 'when more than 5 days before the concert' do
        before(:each) do
          @items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)]
          GildedRose.new(@items).update_quality()
        end
        it 'quality increases by 2' do
          expect(@items[0].quality).to eq 12
        end
        it "sellIn decreases by 1" do
          expect(@items[0].sell_in).to eq 9
        end
      end
      describe "when less than 5 days before the concert" do
        before(:each) do
          @items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 10)]
          GildedRose.new(@items).update_quality()
        end
        it "quality increases by 3" do
          expect(@items[0].quality).to eq 13
        end
        it "sellIn decreases by 1" do
          expect(@items[0].sell_in).to eq 2
        end
      end
      describe "after the concert" do
        before(:each) do
          @items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)]
          GildedRose.new(@items).update_quality()
        end
        it "quality becomes 0" do
          expect(@items[0].quality).to be 0
        end
        it "sellIn decreases by 1" do
          expect(@items[0].sell_in).to be -1
        end
      end
    end
  end
end
