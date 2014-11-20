class Text < ActiveRecord::Base

  default_scope { order(:id) }

  def lock
    if Hardware.lock
      update_attribute(:locked, true)
    else
      false
    end
  end

  def unlock
    if Hardware.unlock
      update_attribute(:locked, false)
    else
      false
    end
  end
end
