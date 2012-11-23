module ZipRecruiter
  class API
    @@api_key = ""

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
