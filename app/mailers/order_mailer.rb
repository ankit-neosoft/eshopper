class OrderMailer < ApplicationMailer
  def order_email(user)
    @user = user
    # attachments.inline['logo.png'] = File.read('/home/webwerks1/Training/Rails/Rails/Eshopper3/app/assets/images/home/logo.png')
    mail(to: @user.email,
      from: 'ankit.neosoft@gmail.com',
      subject: 'Your order has been placed '+@user.first_name,
      # text: 'This mail is sent using Mailgun API via mailgun-ruby'
      )
  end
end
