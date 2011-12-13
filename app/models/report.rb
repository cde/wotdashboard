require 'iconv'

class Report < ActiveRecord::Base
  belongs_to :graphic
  has_many :funnels

  attr_accessible :starts_date, :ends_date, :title, :note, :data, :graphic_id
  validates_presence_of :starts_date, :ends_date, :title
  validates_uniqueness_of :title

  mount_uploader :data, DataUploader



  after_create :set_default_graphic

  def title_slugize(slug = '-')
    sluged = Iconv.iconv('ascii//TRANSLIT//IGNORE', 'utf-8', self.title).to_s
    sluged.gsub!(/&/, 'and')
    sluged.gsub!(/[^\w_\-#{Regexp.escape(slug)}]+/i, slug)
    sluged.gsub!(/#{slug}{2,}/i, slug)
    sluged.gsub!(/^#{slug}|#{slug}$/i, '')
    URI.escape(sluged.downcase, /[^\w_+-]/i)
  end

  def set_default_graphic
    self.graphic = Graphic.find_by_chart_type("adquisition")
  end

end
