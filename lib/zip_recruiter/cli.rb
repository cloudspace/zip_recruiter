require 'thor'
require 'zip_recruiter/job_alerts/cli'

module ZipRecruiter
  class CLI < Thor
    register ZipRecruiter::JobAlerts::CLI, 'jobalerts', 'jobalerts [COMMAND]', 'Type ziprecruiter jobalerts for more help.'
  end
end
