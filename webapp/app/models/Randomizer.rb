class Randomizer
  attr_accessor :namesList, :first_names, :middle_names, :last_names, :sexes, :randNum
  def import_schema(yaml_path)
    return(YAML.load_file(yaml_path)) 
  end

  def initialize()
    @first_names = import_schema('lib/firstnames.yml')['source']
    @middle_names = import_schema('lib/middlenames.yml')['source']
    @last_names = import_schema('lib/lastnames.yml')['source']
    @sexes = import_schema('lib/sexes.yml')['source']
  end

  def gen_random_number(lbound,ubound)
    return rand(lbound..ubound)
  end

  def gen_random_decimal(lbound,ubound)
    randNumber = rand(lbound..ubound)
    result = "%.3f" % randNumber
    return result
  end

  def gen_first_name()
  	return first_names.sample
  end

 def gen_middle_name()
    return middle_names.sample
  end

  def gen_last_name()
  	return last_names.sample
  end

  def gen_sex()
    return sexes.sample
  end
end
