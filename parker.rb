require 'octokit'
require 'dotenv'
require 'hipchat'

module Parker
  class << self

    Dotenv.load

    def github
      @github ||= Octokit::Client.new(access_token: "#{ENV['GITHUB_TOKEN']}")
    end

    def hipchat
      @hipchat ||= HipChat::Client.new(ENV['HIPCHAT_TOKEN'], api_version: 'v2')
    end

    def p1_issues
      github.list_issues("#{ENV['REPO']}", labels: "#{ENV['BUG_LABEL']},#{ENV['P1_LABEL']}")
    end

    def p2_issues
      github.list_issues("#{ENV['REPO']}", labels: "#{ENV['BUG_LABEL']},#{ENV['P2_LABEL']}")
    end

    def issues_info(issues)
      issues.each do |i|
        "Link: #{i.html_url} ##{i.number}: #{i.title}<br>"
      end
    end

    def p1_announcement
      if p1_issues.count > 0
        html += "There are currently <b>#{p1_issues.count}</b> Priority 1 bugs open:<br>"
        p2_issues.each do |i|
          html += "<a href='#{i.html_url}'><b>##{i.number}</b>: #{i.title}<br><a>"
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
          html += "<a href='#{i.html_url}'><b>##{i.number}</b>: #{i.title}<br><a>"
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

    Parker.hipchat["#{ENV['HIPCHAT_ROOM']}"].send('Parker',  Parker.announcements, color: 'purple')
  end
end
