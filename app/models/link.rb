class Link < ApplicationRecord
  belongs_to :user

  scope :hot, -> {
    select('links.url as url')
      .joins('join reads on reads.link_id = links.id')
      .where('reads.created_at > ?', Time.now - 1.day)
      .group("links.url")
      .order('count("reads".id) DESC').limit(10)
  }
  validates :title, presence: true
  validates :url, presence: true
  validate :proper_url

  def proper_url
    unless self.url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]
      self.errors[:url] << 'Invalid URL. Please enter a valid web address.'
    end
  end

  def read?
    if read
      return 'clicked'
    end
  end

  def hot?(hot_reads)
    hot_reads.each do |read|
      return true if url == read['url']
    end
    false
  end

  def top?(hot_reads)
    hot_reads.each_with_index do |read, n|
      return true if url == read['url'] && n.zero?
    end
    false
  end
end
