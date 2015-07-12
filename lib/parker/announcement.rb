require 'parker/issue'
module Parker
  # Announcement class for parker
  class Announcement
    attr_reader :issue_handler

    def initialize
      @issue_handler ||= Parker::Issue.new
    end

    # Generates the body of the hipchat message for priority 1 issues
    # @return [String] containing html formatted hipchat message
    def p1_announcement
      p1s = issue_handler.p1_issues
      html = "There are currently <b>#{p1s.count}</b> #{ENV['P1_LABEL']} bugs open.<br>"
      html += issue_handler.issues_info(p1s)
      html
    end

    # Generates the body of the hipchat message for priority 2 issues
    # @return [String] containing html formatted hipchat message
    def p2_announcement
      p2s = issue_handler.p2_issues
      html = "<br>There are currently <b>#{p2s.count}</b> #{ENV['P2_LABEL']} bugs open.<br>"
      html += issue_handler.issues_info(p2s)
      html
    end

    # Generates the body of the hipchat message for priority 3 issues
    # @return [String] containing html formatted hipchat message
    def p3_announcement
      p3s = issue_handler.p3_issues
      html = "<br>There are currently <b>#{p3s.count}</b> #{ENV['P3_LABEL']} bugs open.<br>"
      html += issue_handler.issues_info(p3s)
      html
    end

    # Collates the the two announcements into one message for ease of transmission
    # @return [String]
    def announcements
      p1_announcement +
        p2_announcement +
        p3_announcement
    end
  end
end
