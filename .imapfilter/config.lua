options.timeout = 120	
options.subscribe = true	
versa = IMAP {  
    server = 'imap.gmail.com',
    username = 'chirag@versa-networks.com',
    password = 'xxxxxxxx',
    ssl = 'ssl3'
}

-- mailboxes
inbox = versa['Inbox']
attic = versa['attic']

-- check status of inbox
-- inbox:check_status()

-- move messages older than a week to attic
old = inbox:is_older(7)
old:move_messages(attic)
