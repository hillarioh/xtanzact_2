class TransferJob < ApplicationJob
  queue_as :default

  def perform(id)
    transfer = Transfer.find(id)

    sender_account = Account.find(transfer.sender.id)
    receiver_account = Account.find(transfer.receiver.id)
    TransactionList.create(account: sender_account, transactionable: transfer)
    TransactionList.create(account: receiver_account, transactionable: transfer)

    sender_account.update(balance: sender_account.balance - transfer.amount)
    receiver_account.update(balance: receiver_account.balance + transfer.amount)

  end
end