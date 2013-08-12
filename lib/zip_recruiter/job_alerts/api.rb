require 'json'
require 'net/http'
require 'securerandom'
require 'uri'
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
      def self.perform_action(action, arg)
        uri = URI.parse("https://api.ziprecruiter.com/job-alerts/v1/#{action.to_s}")

        case action
        when :subscribe, :unsubscribe
          if !File.exists?(arg.to_s)
            raise "File \"#{arg.to_s}\" does not exist."
          end

          file = File.new(File.expand_path(arg.to_s))

          boundary = SecureRandom.urlsafe_base64

          post_body = []
          post_body << "--#{boundary}\r\n"
          post_body << "Content-Disposition: form-data; name=\"content\"; filename=\"#{File.basename(file.path)}\"\r\n"
          post_body << "Content-Type: text/csv\r\n"
          post_body << "\r\n"
          post_body << file.read
          post_body << "\r\n--#{boundary}--\r\n"

          request = Net::HTTP::Post.new(uri.request_uri)
          request.body = post_body.join
          request.content_type = "multipart/form-data; boundary=#{boundary}"

          file.close

        when :status
          uri = URI.parse("#{uri.to_s}/#{arg.to_s}")
          request = Net::HTTP::Get.new(uri.request_uri)
        else
          raise "Unknown action \"#{action.to_s}\"."
        end

        request.basic_auth(api_key, "")

        http = Net::HTTP.new(uri.hostname, uri.port)
        http.use_ssl = true
        response = http.request(request)

        JSON.pretty_generate(JSON.load(response.body))
      end

      ##
      # A Subscribe action is used to upload a collection of job seekers to subscribe to the job alerts program.
      #
      def self.subscribe(path)
        ZipRecruiter::JobAlerts::API.perform_action :subscribe, path
      end

      ##
      # An Unsubscribe action is used to upload a collection of job seekers to unsubscribe from the job alerts program.
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
