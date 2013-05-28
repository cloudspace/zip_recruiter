require 'json'
require 'thor'
require 'thor/group'
require 'zip_recruiter/api'
require 'zip_recruiter/job_alerts/api'

module ZipRecruiter
  module JobAlerts
    class CLI < Thor
      # Hack to override the help message produced by Thor.
      # https://github.com/wycats/thor/issues/261#issuecomment-16880836
      def self.banner(command, namespace = nil, subcommand = nil)
        "#{basename} jobalerts #{command.usage}"
      end

      class_option :api_key, :aliases => "-k", :desc => "Specify your ZipRecruiter Job Alerts API key."

      desc "subscribe [PATH]", "A Subscribe action is used to upload a collection of job seekers to subscribe to the ZipRecruiter job alerts program."
      def subscribe(path)
        ZipRecruiter::API.api_key = options[:api_key] unless options[:api_key].nil?
        if File.exists?(path)
          response = ZipRecruiter::JobAlerts::API.subscribe(path)
          puts JSON.pretty_generate(JSON.parse(response)) unless response.nil?
        else
          puts "File \"#{path}\" does not exist."
        end
      end

      desc "unsubscribe [PATH]", "An Unsubscribe action is used to upload a collection of job seekers to unsubscribe from the ZipRecruiter job alerts program."
      def unsubscribe(path)
        ZipRecruiter::API.api_key = options[:api_key] unless options[:api_key].nil?
        if File.exists?(path)
          response = ZipRecruiter::JobAlerts::API.unsubscribe(path)
          puts JSON.pretty_generate(JSON.parse(response)) unless response.nil?
        else
          puts "File \"#{path}\" does not exist."
        end
      end

      desc "status [TASK_ID]", "A Status action returns the current status of a previously-submitted request."
      def status(task_id)
        ZipRecruiter::API.api_key = options[:api_key] unless options[:api_key].nil?
        response = ZipRecruiter::JobAlerts::API.status(task_id)
        puts JSON.pretty_generate(JSON.parse(response)) unless response.nil?
      end
    end
  end
end
