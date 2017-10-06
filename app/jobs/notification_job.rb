class NotificationJob < ApplicationJob
  queue_as :default

  def perform(id, action)
    # Do something later
    NotificationMailer.send(action, id).deliver_later
  end
end
