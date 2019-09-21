class CustomMailer < ApplicationMailer
  default from: 'HandmadeGarden <noreplay@handmade-garden.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.custom_mailer.tet.subject
  #
  def test
    @greeting = 'Hi'

    mail to: 'yosuke@hunyago-web-garden.com'
  end
end
