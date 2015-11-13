class PatientSchema < Schema
	# Inherits from Schema.rb

	attr_accessor :observations, :fname # Add all other patient attributes we need to track

	def init(filepath)
		super # This loads the parent's init method (which stores self.root)
		# create hash of observations from yaml {:name => {:value => X, :distribution => Y, etc} } and store it in self.observations
		# store all other info e.g. self.fname = Z (from self.root)
	end
end