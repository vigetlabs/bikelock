class Text < ActiveRecord::Base

  default_scope { order(:id) }

  def lock
    Hardware.lock
    update_attribute(:locked, true)
  rescue Net::ReadTimeout
    false
  end

  def unlock
    Hardware.unlock
    update_attribute(:locked, false)
  rescue Net::ReadTimeout
    false
  end
end
