class AppMailer < ActionMailer::Base
  default from: "no-reply@registry.bluebuttion.io"
  def registered(app)
    @app = app
    @token  = app.registration_jwt
    @to = @app.fixed_registration_parameters.contacts
    mail(to: @to, subject: 'App registered!')
  end
end
