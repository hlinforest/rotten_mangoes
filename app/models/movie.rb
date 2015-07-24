class Movie < ActiveRecord::Base

  scope :less_than_90, -> { where('runtime_in_minutes < ?', 90)}
  scope :between_90_to_120, -> {where('runtime_in_minutes between ? and ?', 90, 120)}
  scope :greater_than_120, -> {where('runtime_in_minutes > ?', 120)}

  has_many :reviews

  has_attached_file :poster

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: {only_integer: true}
  validates :description, presence: true
  #validates :poster, presence: true
  validates :release_date, presence: true
  validates_attachment_file_name :poster, :matches => [/png\Z/, /jpe?g\Z/,/gif\Z/]
  #validate :release_date_is_in_the_future

  def review_average
    reviews.size > 0 ? reviews.sum(:rating_out_of_ten)/reviews.size : 0
  end

  protected

  # def release_date_is_in_the_future
  #   if release_date.present?
  #     errors.add(:release_date, "should probably be in the future") if release_date < Date.today
  #   end
  # end
end
