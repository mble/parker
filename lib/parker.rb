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
    def message
      @message ||= Parker::Announcement.new.announcements
    end

    # Returns pretty coloured string for command line
    # @returns [String]
    def cli_message
      message = 'Message sent to '.green
      message += "#{ENV['HIPCHAT_ROOM']}".yellow.bold
      message += ' @ '.green
      message += "#{Time.now}".yellow
      message
    end

    # Sends the collated announcements to the specified hipchat room as Parker,
    # generating a notification within that room
    def go!
      Parker::Client.new.hipchat["#{ENV['HIPCHAT_ROOM']}"].send(
        'Parker', # Name displayed in hipchat
        message, # Message body
        color: 'purple', # Colour of message
        notify: true # Notification sent to room members
      )
      puts cli_message
    end
  end
end
