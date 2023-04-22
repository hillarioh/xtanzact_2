class TransactionJob < ApplicationJob
  queue_as :default

  def perform(id)
    transaction = Transaction.find(id)
    tn_type = transaction.transaction_type
    account = transaction.account
    TransactionList.create(account: account, transactionable: transaction)

    if tn_type == "deposit"
      account.update(balance: account.balance + transaction.amount)
    else
      account.update(balance: account.balance - transaction.amount)
    end        
  end
end
