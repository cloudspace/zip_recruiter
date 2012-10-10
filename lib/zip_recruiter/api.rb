require 'curb'
require 'zip_recruiter'

module ZipRecruiter
  @@api_key = ''

  class API
    ##
    # Sets the API key
    #
    def self.api_key=(api_key)
      @@api_key = api_key
    end

    ##
    # Gets the API key
    #
    def self.api_key
      @@api_key
    end
  end
end
