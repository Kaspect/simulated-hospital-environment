class PatientsController < ApplicationController
# this will look for a new view
	def new
	end
  #takes in a schema file name (such as patient_with_observation_healthy.yml) and returns an instantiated patient object
  #make sure to include the days_of_observation_data, we look within the yml for the inter-measurement interval and generate data accordingly.
  def gen_patient_data(schema_file_name, days_of_observation_data)
    return Patient.new(Schema.new(schema_file_name), days_of_observation_data)
  end
	def create
		@num_patients = params['count'].to_i
    @schema_filename = "lib/patient_with_observation_sepsis.yml"
    @num_days_of_observations = params['days_of_observations'].to_f
    @patients = [*1..@num_patients].map {
      |i|
      gen_patient_data(@schema_filename,@num_days_of_observations) 
    }
	end

end
