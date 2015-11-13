class Fhir 
    def import_schema(yaml_path)
          return(YAML.load_file(yaml_path))
    end
end
