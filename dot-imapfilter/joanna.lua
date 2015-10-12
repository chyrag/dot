options.timeout = 120	
options.subscribe = true	
yahoo = IMAP {  
    server = 'imap.mail.yahoo.com',
    username = 'chyrag',
    password = 'xxxxxxxx',
    ssl = 'ssl3'
}

-- mailboxes
jokes= yahoo['Jokes']
trash= yahoo['Trash']

-- check status of folder
jokes:check_status()

--
-- Delete junk mails
--
print "Deleting mails from Ashima Goel"
result = jokes:contain_from('jiya422@gmail.com')
result:delete_messages()

-- check status of folder
jokes:check_status()
