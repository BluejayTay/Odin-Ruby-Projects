# Implement a method #stock_picker that takes in an array of stock prices, 
#one for each hypothetical day. 
#It should return a pair of days 
#representing the best day to buy 
#and the best day to sell. 
#Days start at 0.

def stock_picker(stock_prices)
  advice = []
  first_low_price = 0
  top_half_of_prices = stock_prices.max(stock_prices.length / 2)
  stock_prices.each do |price|
    if price < top_half_of_prices.min
      first_low_price = price
      break
    end
  end
  sell_price = stock_prices[stock_prices.index(first_low_price)..].max
  sell_day = stock_prices.rindex(sell_price)
  buy_price = stock_prices[0...sell_day].min
  buy_day = stock_prices.index(buy_price)
  advice = [buy_day, sell_day]
  puts "The advice for sell and buy days are: #{advice}"
end

stock_prices = [17,3,6,9,15,8,6,1,10]
puts "Stock price array: #{stock_prices}"
stock_picker(stock_prices)


