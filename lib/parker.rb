require 'dotenv'
require 'parker/client'
require 'parker/announcement'

# Main module for parker
module Parker
  class << self
    Dotenv.load
    # Sets an instance of the message body
    # @returns [String]
    def message
      @message ||= Parker::Announcement.announcements
    end
    # Sends the collated announcements to the specified hipchat room as Parker,
    # generating a notification within that room
    def go!
      Parker::Client.hipchat["#{ENV['HIPCHAT_ROOM']}"].send(
        'Parker', # Name displayed in hipchat
        message, # Message body
        color: 'purple', # Colour of message
        notify: true # Notification sent to room members
      )
    end
  end
end
