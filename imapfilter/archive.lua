dofile '/homes/chirag/.imapfilter/options.lua'
dofile '/homes/chirag/.imapfilter/account.lua'

IN = jnpr.INBOX
MB = jnpr[',mbox']
myemail = 'chirag@juniper.net'
me = 'Chirag Kantharia'

-- others = IN:is_unseen() -
-- 	(IN:contain_to(myemail) + IN:contain_cc(myemail) +
-- 	IN:contain_to(me) + IN:contain_cc(me))
-- others:move_messages(MB)

-- archive old messages (older than 30 days) sent to me
old = IN:is_older(30)
old:move_messages(MB)

IN:check_status()
