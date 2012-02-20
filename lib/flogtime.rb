require "flogtime/version"

class Flogtime
  def self.for(file_path, number_of_commits = nil)
    Flogtime.new(file_path, number_of_commits).flog_method_averages
  end

  attr_reader :number_of_commits, :file_path
  def initialize(file_path, number_of_commits)
    @file_path = file_path
    @number_of_commits = number_of_commits
  end

  def flog_method_averages
    commits.reverse.map do |sha|
      checkout(sha)
      flog_method_average
    end
  end

  def flog
    `flog #{file_path}`
  end

  def flog_score(matcher)
    Float(
      flog(file_path).grep(/#{matcher}/).join.split(/:/).first
    )
  end

  def flog_total
    flog_score(file_path, "flog total")
  end

  def flog_method_average
    flog_score(file_path, "flog/method average")
  end

  def checkout(sha)
    `git checkout #{sha} 2>/dev/null`
  end

  def git_log
    log_lines = number_of_commits.nil? ? `git log #{file_path}` : `git log -n #{number_of_commits} #{file_path}`
    log_lines.grep /^commit/
  end

  def commits
    git_log.map{|c| c.split.last}
  end
end


