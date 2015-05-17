require 'parker/issue'
module Parker
  # Announcement class for parker
  class Announcement
    # Generates the body of the hipchat message for priority 1 issues
    # @return [String] containing html formatted hipchat message
    def self.p1_announcement
      p1s = Parker::Issue.p1_issues
      html = "There are currently <b>#{p1s.count}</b> #{ENV['P1_LABEL']} bugs open.<br>"
      html += Parker::Issue.issues_info(p1s)
      html
    end

    # Generates the body of the hipchat message for priority 2 issues
    # @return [String] containing html formatted hipchat message
    def self.p2_announcement
      p2s = Parker::Issue.p2_issues
      html = "<br>There are currently <b>#{p2s.count}</b> #{ENV['P2_LABEL']} bugs open.<br>"
      html += Parker::Issue.issues_info(p2s)
      html
    end

    # Collates the the two announcements into one message for ease of transmission
    # @return [String]
    def self.announcements
      Parker::Announcement.p1_announcement +
        Parker::Announcement.p2_announcement
    end
  end
end
