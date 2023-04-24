class TransferMailer < ApplicationMailer
    default from: 'okerioh@gmail.com'

    def send_money
        @transfer = params[:transfer]
        @sender = @transfer.sender.user
        @receiver = @transfer.receiver.user
        mail(to: @receiver.email_address, subject: 'Fund Transfer')
    end
end
