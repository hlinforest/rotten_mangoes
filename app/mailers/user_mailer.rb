class UserMailer < ActionMailer::Base
  default from: "NickAllen@riotgames.com"

  def delete_email(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'get fined bro!')
  end
end
