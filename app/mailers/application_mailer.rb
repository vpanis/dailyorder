class ApplicationMailer < ActionMailer::Base
  default from: 'team@dailyorder.co'
  helper ApplicationHelper
  helper UsersHelper
  layout 'mailer'
end
