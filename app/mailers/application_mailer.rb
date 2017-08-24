class ApplicationMailer < ActionMailer::Base
  default from: 'team@dailyorder.co'
  helper ApplicationHelper
  helper UsersHelper
  helper RestaurantsHelper
  layout 'mailer'
end
