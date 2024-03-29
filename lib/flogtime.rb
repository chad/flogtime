require "flogtime/version"
require 'flog'
require 'grit'

class Flogtime
  def self.for(file_path, number_of_commits = nil)
    Flogtime.new(file_path, number_of_commits).flog_method_averages
  end

  attr_reader :number_of_commits, :file_path, :repo_location
  def initialize(file_path, number_of_commits, repo_location = ".")
    @file_path = file_path
    @number_of_commits = number_of_commits
    @repo_location = repo_location
  end

  def flog_method_averages
    commits.reverse.map do |commit|
      checkout(commit.sha)
      [commit.committed_date, flog_method_average]
    end
  end

  def flog
    `flog #{file_path}`.split(/\n/)
  end

  def flog_score(matcher)
    Float(
      flog.grep(/#{matcher}/).join.split(/:/).first
    )
  end

  def flog_total
    flog_score("flog total")
  end

  def flog_method_average
    flog_score("flog/method average")
  end

  def repo
    @repo ||= Grit::Repo.new(repo_location)
  end

  def checkout(sha)
    `git checkout #{sha} 2>/dev/null`
  end

  def git_log
    log_lines = number_of_commits.nil? ? `git log #{file_path}` : `git log -n #{number_of_commits} #{file_path}`
    log_lines.split(/\n/).grep /^commit/
  end

  def commits
    repo.commits('master', false)
  end
end


