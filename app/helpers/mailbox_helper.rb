module MailboxHelper
	def unread_messages_count
    # how to get the number of unread messages for the current user
    # using mailboxer
    mailbox.inbox(:unread => true).count(:id, :distinct => true)
  end

  	def messages_count
  		mailbox.inbox(:unread => true).count(:id, :distinct => true) + mailbox.inbox(:unread => false).count(:id, :distinct => true) 
  	end
end
