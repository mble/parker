require 'parker/client'
module Parker
  # Issue class for parker
  class Issue
    attr_reader :github

    def initialize
      @github ||= Parker::Client.new.github
    end

    # Get a list of P1 bugs for a repo, requires the following ENV variables:
    #   REPO - specifies the Github repo to pull issues from
    #   BUG_LABEL - the label you use to identify bugs
    #   P1_LABEL - the label you use to identify priority 1 bugs
    # @return [Array] of P1 issues for the specified repo
    def p1_issues
      sla_filter github.list_issues("#{ENV['REPO']}", labels: "#{ENV['BUG_LABEL']},#{ENV['P1_LABEL']}")
    end

    # Get a list of P2 bugs for a repo, requires the following ENV variables:
    #   REPO - specifies the Github repo to pull issues from
    #   BUG_LABEL - the label you use to identify bugs
    #   P2_LABEL - the label you use to identify priority 2 bugs
    # @return [Array] of P2 issues for the specified repo
    def p2_issues
      sla_filter github.list_issues("#{ENV['REPO']}", labels: "#{ENV['BUG_LABEL']},#{ENV['P2_LABEL']}")
    end

    # Get a list of P3 bugs for a repo, requires the following ENV variables:
    #   REPO - specifies the Github repo to pull issues from
    #   BUG_LABEL - the label you use to identify bugs
    #   P3_LABEL - the label you use to identify priority 3 bugs
    # @return [Array] of P3 issues for the specified repo
    def p3_issues
      sla_filter github.list_issues("#{ENV['REPO']}", labels: "#{ENV['BUG_LABEL']},#{ENV['P3_LABEL']}")
    end

    # Return a string containing the url, issue number, title and how long an issue has been open
    # for each issue in a collection of issues
    # @param issues [Array] array containing issue objects
    # @return [String]
    def hipchat_issues_info(issues)
      html = ''
      issues.each do |issue|
        html += "<a href='#{issue.html_url}'><b>##{issue.number}</b>: #{issue.title}</a>
                Open for <b>#{open_for_days(issue)}</b> days.<br>"
      end
      html
    end

    def slack_issues_info(issues)
      text = ''
      issues.each do |issue|
        text += "<#{issue.html_url}|*##{issue.number}*: #{issue.title}> Open for *#{open_for_days(issue)}* days.\n"
      end
      text
    end

    private

    # Calculates the time in days an issue has been open for
    # @param issue [Object] Github issue object
    # @return [Integer]
    def open_for_days(issue)
      ((Time.now - issue.created_at).round) / 86_400
    end

    def sla_filter(issues)
      if ENV['FULL_ISSUE_LIST']
        issues
      else
        issues.reject { |issue| issue.labels.map(&:name).include?('QA Accepted') || open_for_days(issue) >= 90 }
      end
    end
  end
end
