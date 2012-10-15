require 'curb'
require 'zip_recruiter/api'

module ZipRecruiter
  module JobAlerts
    class API < ZipRecruiter::API
      ##
      # Performs the specified API action.
      #
      # This will perform the specified API action. The action must be one of:
      #
      # * +subscribe+
      # * +unsubscribe+
      # * +status+
      #
      # The +subscribe+ and +unsubscribe+ actions require an argument that is the
      # path to a CSV file. The +status+ action requires an argument that is the
      # task ID of a previously submitted API request.
      #
      # You should not call this method directly, but instead use one of the
      # helper methods below.
      #
      def self.perform_action(action, arg)
        c = Curl::Easy.new("https://api.ziprecruiter.com/job-alerts/v1/#{action.to_s}")
        c.http_auth_types = :basic
        c.userpwd = "#{api_key}:"

        case action
        when :subscribe, :unsubscribe
          path = File.expand_path(arg.to_s)
          if !File.exists?(path)
            raise "File \"#{path}\" does not exist."
          end

          c.multipart_form_post = true
          c.http_post(Curl::PostField.file('content', path.to_s)) # http_post calls perform

        when :status
          c.url += "/#{arg.to_s}"
          c.perform

        else
          raise "Unknown action \"#{action.to_s}\"."
        end

        c.body_str
      end

      ##
      # A Subscribe action is used to upload a collection of job seekers to subscribe to our job alerts program.
      #
      def self.subscribe(path)
        ZipRecruiter::JobAlerts::API.perform_action :subscribe, path
      end

      ##
      # An Unsubscribe action is used to upload a collection of job seekers to unsubscribe from our job alerts program.
      #
      def self.unsubscribe(path)
        ZipRecruiter::JobAlerts::API.perform_action :unsubscribe, path
      end

      ##
      # A Status action returns the current status of a previously-submitted request.
      #
      def self.status(task_id)
        ZipRecruiter::JobAlerts::API.perform_action :status, task_id
      end
    end
  end
end
