require 'yaml'
class PagesController < ApplicationController
  
  def import_schema(yaml_path)
    return(YAML.load_file(yaml_path)) 
  end

  def keys_to_fill(schema_hash)
    return(schema_hash.keys)
  end

  def random_element(l)
   return(l[0]) #TODO make actually random
  end 
  
  def gen_rand_element(source, gen_command)
    case gen_command
    when 'uar_element_from_list'
      return(random_element(source))
    else
      return 'no valid selection_type was specified' 
    end
  end
  def run_random_generation(patient)
    patient_keys = keys_to_fill(patient)
    patient_keys.each do |key|
       puts "lets randomize #{key}"
       patient[key] = gen_rand_element(patient[key]['source'],patient[key]['selection_type']) 
    end 
    return(patient) #todo make this the randomized patient
  end 
    
  def home
    patient = import_schema('lib/patient_schema.yml')
    random_patient = run_random_generation(patient)
    @greeting = random_patient.to_json
  end
end
