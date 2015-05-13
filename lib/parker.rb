require 'octokit'
require 'dotenv'
require 'hipchat'

# Main module for parker
module Parker
  class << self
    Dotenv.load

    # Establish connection to Github via API
    # @note requires a valid API token for Github
    def github
      @github ||= Octokit::Client.new(access_token: "#{ENV['GITHUB_TOKEN']}")
    end

    # @note requires a valid API token for Hipchat (Room or User)
    def hipchat
      @hipchat ||= HipChat::Client.new(ENV['HIPCHAT_TOKEN'], api_version: 'v2')
    end

    # Get a list of P1 bugs for a repo, requires the following ENV variables:
    #   REPO - specifies the Github repo to pull issues from
    #   BUG_LABEL - the label you use to identify bugs
    #   P1_LABEL - the label you use to identify priority 1 bugs
    # @return [Array] of P1 issues for the specified repo
    def p1_issues
      github.list_issues("#{ENV['REPO']}", labels: "#{ENV['BUG_LABEL']},#{ENV['P1_LABEL']}")
    end

    # Get a list of P1 bugs for a repo, requires the following ENV variables:
    #   REPO - specifies the Github repo to pull issues from
    #   BUG_LABEL - the label you use to identify bugs
    #   P2_LABEL - the label you use to identify priority 2 bugs
    # @return [Array] of P1 issues for the specified repo
    def p2_issues
      github.list_issues("#{ENV['REPO']}", labels: "#{ENV['BUG_LABEL']},#{ENV['P2_LABEL']}")
    end

    # Return a string containing the url, issue number and title for each issue in a collection of issues
    # @param issues [Array] array containing issue objects
    # @return [String]
    def issues_info(issues)
      issues.each do |i|
        "Link: #{i.html_url} ##{i.number}: #{i.title}<br>"
      end
    end

    def open_for_days(issue)
      ((Time.now - issue.created_at).round) / 86_400
    end

    def p1_announcement
      if p1_issues.count > 0
        html += "There are currently <b>#{p1_issues.count}</b> Priority 1 bugs open:<br>"
        p2_issues.each do |i|
          html += "<a href='#{i.html_url}'><b>##{i.number}</b>: #{i.title}</a> Open for <b>#{open_for_days(i)}</b> days.<br>"
        end
        html
      else
        "There are currently <b>#{p1_issues.count}</b> Priority 1 bugs open.<br>"
      end
    end

    def p2_announcement
      if p2_issues.count > 0
        html = "<br>There are currently <b>#{p2_issues.count}</b> Priority 2 bugs open:<br>"
        p2_issues.each do |i|
          html += "<a href='#{i.html_url}'><b>##{i.number}</b>: #{i.title}</a> Open for <b>#{open_for_days(i)}</b> days.<br>"
        end
        html
      else
        "<br>There are currently #{p2_issues.count} Priority 2 bugs open."
      end
    end

    def announcements
      Parker.p1_announcement +
        Parker.p2_announcement
    end

    def go!
      Parker.hipchat["#{ENV['HIPCHAT_ROOM']}"].send('Parker',  Parker.announcements, color: 'purple', notify: true)
    end
  end
end
