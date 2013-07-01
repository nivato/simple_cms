class Page < ActiveRecord::Base
  include PositionMover
  
  attr_accessible :name, :permalink, :position, :visible, :subject_id
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  belongs_to :subject
  has_many :sections
  
  validates_presence_of :name
  validates_length_of :name, :minimum => 3, :maximum => 255
  
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255
  validates_uniqueness_of :permalink, :scope => :subject_id
  
  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order("pages.position ASC")
  
  private
  
  def position_scope
    "pages.subject_id = #{subject_id.to_i}"
  end
  
end
