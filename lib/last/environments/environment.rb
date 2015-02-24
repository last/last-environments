module Last
module Environments

module Environment
  @@variables = {}

  def expect(variable_name, **options)
    environment_name           = options[:in] || :default
    @@variables[variable_name] = environment_name
  end

  def validate(environment_hash = ENV, environment_name = (ENV["RACK_ENV"] || :default))
    @@variables.each do |variable_name, target_environment|
      next if (target_environment != :default) && (target_environment != environment_name.to_sym)
      raise variable_name if environment_hash["#{variable_name.upcase}"].nil?
    end
  end
end

end
end
