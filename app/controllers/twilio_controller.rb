class TwilioController < ApplicationController
  skip_before_action :check_for_lockup

  def process_sms
    @response = handle_text(params)

    render 'response.xml.erb', :content_type => 'text/xml'
  end

  private

  def handle_text(params)
    from = params[:From]
    body = params[:Body]

    if locked_already?
      if authorized_to_unlock
        return last_text.unlock ? "Unlocked!" : system_down
      else
        return "Sorry. Invalid unlock attempt"
      end
    else
      text = Text.create(from: from, lock_phrase: body)

      return text.lock ? "Locked with passphrase: '#{body}'" : system_down
    end
  end

  def locked_already?
    last_text.locked?
  end

  def authorized_to_unlock
    from == last_text.from && body == last_text.lock_phrase
  end

  def last_text
    @last_text ||= Text.last
  end

  def system_down
    "Sorry. The system is not responding"
  end

end
