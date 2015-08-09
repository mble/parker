require 'hipchat'
require 'octokit'
require 'slack-ruby-client'
require 'erb' # HTTParty has an undeclared dependency on ERB

module Parker
  # Client class for Parker
  class Client
    attr_reader :hipchat, :github, :slack

    def initialize
      @hipchat ||= HipChat::Client.new(ENV['HIPCHAT_TOKEN'], api_version: 'v2')
      @github ||= Octokit::Client.new(access_token: "#{ENV['GITHUB_TOKEN']}")
      @slack ||= Slack::Web::Client.new(token: ENV['SLACK_TOKEN'])
    end
  end
end
