require 'iconv'

class Report < ActiveRecord::Base
  belongs_to :graphic

  has_many :funnels

  attr_accessible :starts_date, :ends_date, :title, :note, :data, :graphic_id
  validates_presence_of :starts_date, :ends_date, :title
  validates_uniqueness_of :title

  mount_uploader :data, DataUploader

  scope :ads, where(traffic_type: "Ads").order("start_date asc")
  scope :direct, where(traffic_type: "Direct").order("start_date asc")



  def title_slugize(slug = '-')
    sluged = Iconv.iconv('ascii//TRANSLIT//IGNORE', 'utf-8', self.title).to_s
    sluged.gsub!(/&/, 'and')
    sluged.gsub!(/[^\w_\-#{Regexp.escape(slug)}]+/i, slug)
    sluged.gsub!(/#{slug}{2,}/i, slug)
    sluged.gsub!(/^#{slug}|#{slug}$/i, '')
    URI.escape(sluged.downcase, /[^\w_+-]/i)
  end

end
