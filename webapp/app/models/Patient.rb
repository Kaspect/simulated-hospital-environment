class Patient < Fhir 
  #takes in a birthdate, outputs the number of years 
  def gen_age(birthdate)
    return((1.minute.ago - birthdate)/31536000) #divides by number of seconds in a year
  end
  attr_accessor :age, :first, :last, :sex, :middle, :street_address, :city, :state, :zip, :cell_phone, :gender_written_out, :birthdate, :observations, :schema
  def sex()
    choices = ["M", "F", "Other"]
    return(choices[0])
  end 
  def gen_bday(min,max)
    rand(min*365*24*60...max*365*24*60).minutes.ago
  end

  # for each of the observation types, generate_n_days for that given observation
  def gen_observation_set(schema, days_of_observations)
    big_observation_list = []
    # for each observation type in the schema...
    schema.observations.each do |x|
      big_observation_list << generate_n_days_of_data(x, days_of_observations)
    end
    return(big_observation_list.flatten)
  end

  # takes in an observation specification for one specific type of observation. e.g. Heartrate, 2 days of measurements
  def generate_n_days_of_data(observation_specification, days_of_observations)
    time_we_began_observing = days_of_observations.days.ago
    now = 0.seconds.ago
    if days_of_observations <= 0
      raise "error"
    end
    observation_array = make_observations_until_time_runs_out(observation_specification, now, time_we_began_observing)
    return(observation_array.flatten)
  end
 
  # takes in the observation specifications (in specific format, as specified via the yaml), and takes in the range of times
  # within which the times will be observes
  def make_observations_until_time_runs_out(observation_specification, now, time_we_began_observing)
    # time_traveler serves as a counter for time, starting at 'time_we_began_observing', and ending at or before 'now'
    observation_list = []
    time_traveler = time_we_began_observing
    until time_traveler >= now
      observation_list << gen_raw_observation(observation_specification, time_collected=time_traveler)
      interval = observation_specification[1]["intermeasurement_interval_seconds"]
      time_traveler += interval.seconds
    end
    return(observation_list.flatten)
  end

  # generates an observation, based on just the name, unit, distribution, 
  # and other parameters included in the source object.
  def gen_raw_observation(observation_specification, time_collected)
      obs = {}
      x = observation_specification
      #put in the observation with the newly created value
      obs['name'] = x[0]
      obs['unit'] = x[1]['unit']
      obs['timestamp'] = time_collected
      obs['value'] = Distribution.new().generate_value_based_on_distribution(distribution=x[1]["distribution"],
                                                                     range=x[1]['range'], 
                                                                     mean=x[1]['mean'], 
                                                                     sd=x[1]['sd']) 
      return(obs)
  end

  #takes in an instantiated Schema object (see Schema.rb) and the number of days through which we will generate observations. 1.0 days of obserations will generate approx 24 observations if the inter-measurement interval is every hour.
  def initialize(schema, days_of_observations)
    @schema = schema
    @observations = gen_observation_set(schema, days_of_observations) 
    @first =Faker::Name.first_name 
    @middle = Faker::Name.first_name
    @last =Faker::Name.last_name 
    @sex = sex()
    @street_address = Faker::Address.street_address
    @city = Faker::Address.city
    @state = Faker::Address.state
    @zip = Faker::Address.zip
    @cell_phone = Faker::PhoneNumber.cell_phone
    @gender_written_out = ['male', 'female', 'other'].sample
    @birthdate = gen_bday(12,95)
    @age = gen_age(birthdate)
  end

end
