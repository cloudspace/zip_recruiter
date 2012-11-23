require 'thor'
require 'thor/group'
require 'zip_recruiter/api'
require 'zip_recruiter/job_alerts/api'

module ZipRecruiter
  module JobAlerts
    class CLI < Thor
      class_option :api_key, :aliases => "-k", :desc => "Specify your ZipRecruiter Job Alerts API key."

      desc "subscribe [PATH]", "A Subscribe action is used to upload a collection of job seekers to subscribe to the ZipRecruiter job alerts program."
      def subscribe(path)
        ZipRecruiter::API.api_key = options[:api_key] unless options[:api_key].nil?
        if File.exists?(path)
          puts ZipRecruiter::JobAlerts::API.subscribe(path)
        else
          puts "File \"#{path}\" does not exist."
        end
      end

      desc "unsubscribe [PATH]", "An Unsubscribe action is used to upload a collection of job seekers to unsubscribe from the ZipRecruiter job alerts program."
      def unsubscribe(path)
        ZipRecruiter::API.api_key = options[:api_key] unless options[:api_key].nil?
        if File.exists?(path)
          puts ZipRecruiter::JobAlerts::API.unsubscribe(path)
        else
          puts "File \"#{path}\" does not exist."
        end
      end

      desc "status [TASK_ID]", "A Status action returns the current status of a previously-submitted request."
      def status(task_id)
        ZipRecruiter::API.api_key = options[:api_key] unless options[:api_key].nil?
        puts ZipRecruiter::JobAlerts::API.status(task_id)
      end
    end
  end
end
