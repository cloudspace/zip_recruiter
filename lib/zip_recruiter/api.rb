require 'curb'
require 'zip_recruiter'

module ZipRecruiter
  class API
    @@api_key = ''

    def self.api_key=(api_key)
      @@api_key = api_key
    end

    def self.perform_action(action, arg)
      c = Curl::Easy.new("https://api.ziprecruiter.com/job-alerts/v1/#{action.to_s}")
      c.http_auth_types = :basic
      c.userpwd = "#{@@api_key}:"

      case action
      when :subscribe, :unsubscribe
        c.multipart_form_post = true
        c.http_post(Curl::PostField.file('content', arg.to_s))
      when :status
        c.url += "/#{arg.to_s}"
        c.perform
      else
        raise "Unknown ZipRecruiter action \"#{action.to_s}\"."
      end

      c.body_str
    end

    def self.subscribe(path)
      ZipRecruiter::API.perform_action :subscribe, path
    end

    def self.unsubscribe(path)
      ZipRecruiter::API.perform_action :unsubscribe, path
    end

    def self.status(task_id)
      ZipRecruiter::API.perform_action :status, task_id
    end
  end
end
