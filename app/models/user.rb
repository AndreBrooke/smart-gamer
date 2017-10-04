class User < ApplicationRecord
  include Clearance::User
	  def self.from_omniauth(auth)
	    info = auth['info']

	    # Convert from 64-bit to 32-bit
	    user = find_or_initialize_by(uid: (auth['uid'].to_i - 76561197960265728).to_s)
	    user.nickname = info['nickname']
	    user.avatar_url = info['image']
	    user.profile_url = info['urls']['Profile']
	    user.name = info['name']
	    user.email = "example@na.com"
	    user.password = SecureRandom.hex(10)
	    user.personastate = auth["extra"]['raw_info']['personastate']
	    user
	  end
end
