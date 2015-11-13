class OrderSchema < Schema
	# Inherits from Schema.rb

	attr_accessor :observations, :fname # Add all other patient attributes we need to track

	def init(filepath)
		super # This loads the parent's init method (which stores self.root)
	end
end