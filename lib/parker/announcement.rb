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
    def p1_announcement(client)
      p1s = issue_handler.p1_issues
      case client
      when 'hipchat'
        html = "There are currently <b>#{p1s.count}</b> #{ENV['P1_LABEL']} bugs open.<br>"
        html += issue_handler.hipchat_issues_info(p1s)
      when 'slack'
        html = "There are currently *#{p1s.count}* #{ENV['P1_LABEL']} bugs open.\n"
        html += issue_handler.slack_issues_info(p1s)
      end
      html
    end

    # Generates the body of the hipchat message for priority 2 issues
    # @return [String] containing html formatted hipchat message
    def p2_announcement(client)
      p2s = issue_handler.p2_issues
      case client
      when 'hipchat'
        html = "There are currently <b>#{p2s.count}</b> #{ENV['P2_LABEL']} bugs open.<br>"
        html += issue_handler.hipchat_issues_info(p2s)
      when 'slack'
        html = "There are currently *#{p2s.count}* #{ENV['P2_LABEL']} bugs open.\n"
        html += issue_handler.slack_issues_info(p2s)
      end
      html
    end

    # Generates the body of the hipchat message for priority 3 issues
    # @return [String] containing html formatted hipchat message
    def p3_announcement(client)
      p3s = issue_handler.p3_issues
      case client
      when 'hipchat'
        html = "There are currently <b>#{p3s.count}</b> #{ENV['P3_LABEL']} bugs open.<br>"
        html += issue_handler.hipchat_issues_info(p3s)
      when 'slack'
        html = "There are currently *#{p3s.count}* #{ENV['P3_LABEL']} bugs open.\n"
        html += issue_handler.slack_issues_info(p3s)
      end
      html
    end

    # Collates the the two announcements into one message for ease of transmission
    # @return [String]
    def announcements(client)
      p1_announcement(client) +
        p2_announcement(client) +
        p3_announcement(client)
    end
  end
end
