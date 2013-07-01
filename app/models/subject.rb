class Subject < ActiveRecord::Base
  include PositionMover
  
  attr_accessible :name, :position, :visible
  
  has_many :pages
  
  validates_presence_of :name
  validates_length_of :name, :minimum => 3, :maximum => 255
  
  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order("subjects.position ASC")
  scope :search, lambda{|query| where(["name LIKE ?", "%#{query}%"])}
  
end
