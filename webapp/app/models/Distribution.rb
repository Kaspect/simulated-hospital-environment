class Distribution
  #@param observation_specification a hash object that contains the range for a uar distribution
  #@param range 2 element array with the min and max element.
  def apply_uar(range)
    return(rand(range[0]...range[1])) #range0 is min, range1 is max
  end
  #takes in the observation specification,identifies the distribution type, and calls the appropriate randomizer 
  def generate_value_based_on_distribution(distribution=nil, range=nil, sd=nil, mean=nil)
    case distribution 
    when 'uniform'
      return(apply_uar(range))
    else
      raise ArgumentError, "No valid distribution specified" 
    end
  end

	def get_value(specification, distribution_name)
		# use a case/when statement to return a value based on both the specificaiton (e.g. range [0.6,1.0]) or distribution_name (e.g. "uniform")
	end

end
