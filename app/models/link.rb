class Link < ApplicationRecord
  scope :hot, -> {
    select('links.url as url')
      .joins('join reads on reads.link_id = links.id')
      .where('reads.created_at > ?', Time.now - 1.day)
      .group("links.url")
      .order('count("reads".id) DESC').limit(10)
  }
  validates :title, presence: true
  validate :proper_url

  def proper_url
    unless self.url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]
      self.errors[:url] << 'Invalid URL. Please enter a valid web address.'
    end
  end
end
