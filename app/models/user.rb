class User < ApplicationRecord
  include Clearance::User
  enum status: [ :gamer, :admin ]
end
