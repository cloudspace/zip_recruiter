require 'thor'
require 'thor/group'
require 'zip_recruiter/api'
require 'zip_recruiter/job_alerts/api'

module ZipRecruiter
  class ::JobAlerts < Thor
    class_option :api_key, :aliases => "-k", :desc => "Specify your ZipRecruiter Job Alerts API key."

    desc "subscribe [PATH]", "A Subscribe action is used to upload a collection of job seekers to subscribe to the ZipRecruiter job alerts program."
    def subscribe(path)
      ZipRecruiter::API.api_key = options[:api_key]
      p ZipRecruiter::JobAlerts::API.subscribe(path)
    end

    desc "unsubscribe [PATH]", "An Unsubscribe action is used to upload a collection of job seekers to unsubscribe from the ZipRecruiter job alerts program."
    def unsubscribe(path)
      ZipRecruiter::API.api_key = options[:api_key]
      p ZipRecruiter::JobAlerts::API.unsubscribe(path)
    end

    desc "status [TASK_ID]", "A Status action returns the current status of a previously-submitted request."
    def status(task_id)
      ZipRecruiter::API.api_key = options[:api_key]
      p ZipRecruiter::JobAlerts::API.status(task_id)
    end
  end
end
