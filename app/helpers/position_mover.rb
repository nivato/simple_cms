module PositionMover
  
  def move_to_position(new_position)
    max_position = self.class.where(position_scope).count
    unless new_position.nil?
      new_position = [[1, new_position.to_i].max, max_position].min
    end
    if position == new_position
      return true
    elsif position.nil?
      increment_items(new_position, 1000000)
    elsif new_position.nil?
      decrement_items(position+1, 1000000)
    elsif new_position < position
      increment_items(new_position, position-1)
    elsif new_position > position
      decrement_items(position+1, new_position)
    end
    return update_attribute(:position, new_position)
  end
  
  private
  
  def position_scope
    # default. should be overrode. won't affect SQL "where" condition
    "1=1"
  end
  
  def increment_items(first, last)
    items = self.class.where(["position >= ? AND position <= ? AND #{position_scope}", first, last])
    items.each do |i|
      i.update_attribute(:position, i.position + 1)
    end
  end
  
  def decrement_items(first, last)
    items = self.class.where(["position >= ? AND position <= ? AND #{position_scope}", first, last])
    items.each do |i|
      i.update_attribute(:position, i.position - 1)
    end
  end
  
end