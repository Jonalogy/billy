class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def is_authenticated
    unless current_user
      flash[:danger] = "Credentials Invalid!!"
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  private

  def sms recipient_no, message

      account_sid = ENV["twilio_account_sid"]
      auth_token = ENV["twilio_auth_token"]
      twilio_from_no = ENV["twilio_from_no"]
      puts "auth_token = #{auth_token}"
      puts "twilio_from_no = #{twilio_from_no}"

      begin
        @client = Twilio::REST::Client.new account_sid, auth_token
        @client.account.messages.create({
          :from => twilio_from_no,
          :to => recipient_no,
          :body => message,
        })
        rescue Twilio::REST::RequestError => e
          puts e.message
        end
        puts "Twilio: Number #{recipient_no} has been notified!"
    end


end
