require 'thor'
require 'zip_recruiter'

module ZipRecruiter
  class CLI < Thor
    class_option :api_key, :aliases => "-k", :desc => "Specify your ZipRecruiter Job Alerts API key."

    desc "subscribe PATH", "A Subscribe action is used to upload a collection of job seekers to subscribe to our job alerts program."
    def subscribe(path)
      ZipRecruiter::API.api_key = options[:api_key]
      p ZipRecruiter::API.subscribe(path)
    end

    desc "unsubscribe PATH", "An Unsubscribe action is used to upload a collection of job seekers to unsubscribe from our job alerts program."
    def unsubscribe(path)
      ZipRecruiter::API.api_key = options[:api_key]
      p ZipRecruiter::API.unsubscribe(path)
    end

    desc "status TASK_ID", "A Status action returns the current status of a previously-submitted request."
    def status(task_id)
      ZipRecruiter::API.api_key = options[:api_key]
      p ZipRecruiter::API.status(task_id)
    end
  end
end
