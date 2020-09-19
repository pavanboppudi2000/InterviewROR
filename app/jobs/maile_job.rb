class MaileJob < ApplicationJob
  queue_as :default

  def perform(email)
    UserMailer.remind_interview(email).deliver
  end
  
end
