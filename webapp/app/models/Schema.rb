class Schema

attr_accessor :root, :observations
	def initialize(filepath)
		@root = Fhir.new().import_schema(filepath) # load yaml and store it in self.root
    @observations = @root['observations']
	end

end
