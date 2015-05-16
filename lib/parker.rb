require 'octokit'
require 'dotenv'
require 'hipchat'
require 'parker/client'

# Main module for parker
module Parker
  class << self
    Dotenv.load
    # Get a list of P1 bugs for a repo, requires the following ENV variables:
    #   REPO - specifies the Github repo to pull issues from
    #   BUG_LABEL - the label you use to identify bugs
    #   P1_LABEL - the label you use to identify priority 1 bugs
    # @return [Array] of P1 issues for the specified repo
    def p1_issues
      Parker::Client.github.list_issues("#{ENV['REPO']}", labels: "#{ENV['BUG_LABEL']},#{ENV['P1_LABEL']}")
    end

    # Get a list of P1 bugs for a repo, requires the following ENV variables:
    #   REPO - specifies the Github repo to pull issues from
    #   BUG_LABEL - the label you use to identify bugs
    #   P2_LABEL - the label you use to identify priority 2 bugs
    # @return [Array] of P1 issues for the specified repo
    def p2_issues
      Parker::Client.github.list_issues("#{ENV['REPO']}", labels: "#{ENV['BUG_LABEL']},#{ENV['P2_LABEL']}")
    end

    # Return a string containing the url, issue number, title and how long an issue has been open
    # for each issue in a collection of issues
    # @param issues [Array] array containing issue objects
    # @return [String]
    def issues_info(issues)
      html = ''
      issues.each do |i|
        html += "<a href='#{i.html_url}'><b>##{i.number}</b>: #{i.title}</a> Open for <b>#{open_for_days(i)}</b> days.<br>"
      end
      html
    end

    # Calculates the time in days an issue has been open for
    # @param issue [Object] Github issue object
    # @return [Integer]
    def open_for_days(issue)
      ((Time.now - issue.created_at).round) / 86_400
    end

    # Generates the body of the hipchat message for priority 1 issues
    # @return [String] containing html formatted hipchat message
    def p1_announcement
      html = "There are currently <b>#{p1_issues.count}</b> #{ENV['P1_LABEL']} bugs open.<br>"
      html += issues_info(p1_issues)
      html
    end

    # Generates the body of the hipchat message for priority 2 issues
    # @return [String] containing html formatted hipchat message
    def p2_announcement
      html = "<br>There are currently <b>#{p2_issues.count}</b> #{ENV['P2_LABEL']} bugs open.<br>"
      html += issues_info(p2_issues)
      html
    end

    # Collates the the two announcements into one message for ease of transmission
    # @return [String]
    def announcements
      Parker.p1_announcement +
        Parker.p2_announcement
    end

    # Sends the collated announcements to the specified hipchat room as Parker, generating a notification
    # within that room
    def go!
      Parker::Client.hipchat["#{ENV['HIPCHAT_ROOM']}"].send('Parker',  Parker.announcements, color: 'purple', notify: true)
    end
  end
end
