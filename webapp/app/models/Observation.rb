class Observation < Fhir
  require 'Distribution'
  attr_accessor :observations
  def gen_observation(schema)
    val = []
    schema['obs'].each do |observation_specification| 
      val << Distribution.new().generate_value_based_on_distribution(observation_specification) 
    end
    return(val)
  end
  #TODO add method that takes in a string ('bpm') and outputs the object values
  def initialize(type)
    case type
    when 'observation_healthy.yml'
      @observations = gen_observation(type)
    when 'observation_around_sirs.yml'
      @observations = gen_observation(type)
    when 'observation_sirs.yml'
      @observations = gen_observation(type)
    when 'observation_sepsis.yml'
      @observations = gen_observation(type)
    else
      puts("no such patient_type was found")
    end
  end
end
