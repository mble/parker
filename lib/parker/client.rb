require 'hipchat'
require 'octokit'
require 'erb' # HTTParty has an undeclared dependency on ERB

module Parker
  # Client class for Parker
  class Client
    # Establish connection to Github via API
    # @note requires a valid API token for Github
    def self.github
      @github ||= Octokit::Client.new(access_token: "#{ENV['GITHUB_TOKEN']}")
    end

    # Establish connection to Hipchat via API
    # @note requires a valid API token for Hipchat (Room or User)
    def self.hipchat
      @hipchat ||= HipChat::Client.new(ENV['HIPCHAT_TOKEN'], api_version: 'v2')
    end
  end
end
