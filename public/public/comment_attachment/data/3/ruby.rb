class Cart

	attr_reader :items

	include ItemContainer

	def initialize(options = [])
	@items = options
	end

end

cart = Cart.new(["samsung", "nokia"])
cart.add_item "iphone"
cart.remove_item "samsung"
puts cart.items