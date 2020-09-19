class HardWorkerWorker
  include Sidekiq::Worker

  def perform(email,st,en)
    # Do something
    UserMailer.remind_interview(email,st,en).deliver
  end
end
