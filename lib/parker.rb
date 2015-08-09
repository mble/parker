require 'dotenv'
require 'colorize'
require 'parker/client'
require 'parker/announcement'

# Main module for parker
module Parker
  class << self
    Dotenv.load
    # Sets an instance of the message body
    # @returns [String]
    def message(client)
      @message ||= Parker::Announcement.new.announcements(client)
    end

    # Returns pretty coloured string for command line
    # @returns [String]
    def cli_message(client = '')
      message = 'Message sent to '.green
      message += "#{ENV["#{client.upcase}_ROOM"]}".yellow.bold
      message += ' @ '.green
      message += "#{Time.now}".yellow
      message
    end

    # Sends the collated announcements to the specified hipchat room as Parker,
    # generating a notification within that room
    def go!(options = {})
      case options[:client]
      when 'hipchat'
        send_hipchat_message
      when 'slack'
        send_slack_message
      else
        puts 'ERROR: Please specify hipchat or slack as arguments.'.red
      end
      begin
        puts cli_message options[:client]
      rescue
        nil
      end
    end

    def send_hipchat_message
      Parker::Client.new.hipchat["#{ENV['HIPCHAT_ROOM']}"].send(
        'Parker', # Name displayed in hipchat
        message('hipchat'), # Message body
        color: 'purple', # Colour of message
        notify: true # Notification sent to room members
      )
    end

    def send_slack_message
      Parker::Client.new.slack.chat_postMessage(
        channel: slack_channel_id,
        text: message('slack'),
        as_user: true
      )
    end

    def slack_channel_id
      slack = Parker::Client.new.slack
      if ENV['DEBUG'] == 'true'
        slack.groups_list['groups'].detect { |g| g['name'] == 'parker-testbed' }.fetch('id')
      else
        slack.channels_list['channels'].detect { |c| c['name'] == ENV['SLACK_ROOM'] }.fetch('id')
      end
    end
  end
end
