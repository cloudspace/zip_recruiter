require 'thor'
require 'zip_recruiter'
require 'zip_recruiter/job_alerts'

module ZipRecruiter
  class CLI < Thor
    register ::JobAlerts, 'jobalerts', 'jobalerts [COMMAND]', 'Type ziprecruiter jobalerts for more help.'
  end
end
