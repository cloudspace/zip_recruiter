require 'thor'
require 'zip_recruiter/job_alerts/cli'

module ZipRecruiter
  class CLI < Thor
    class_option :api_key, :aliases => "-k", :desc => "Specify your ZipRecruiter API key."
    register ZipRecruiter::JobAlerts::CLI, 'jobalerts', 'jobalerts [COMMAND]', 'Type ziprecruiter jobalerts for more help.'
  end
end
