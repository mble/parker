require 'hipchat'
require 'octokit'
require 'erb' # HTTParty has an undeclared dependency on ERB

module Parker
  # Client class for Parker
  class Client
    attr_reader :hipchat, :github

    def initialize
      @hipchat ||= HipChat::Client.new(ENV['HIPCHAT_TOKEN'], api_version: 'v2')
      @github ||= Octokit::Client.new(access_token: "#{ENV['GITHUB_TOKEN']}")
    end
  end
end
