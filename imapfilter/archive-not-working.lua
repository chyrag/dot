-- the following is required if running in standalone mode
dofile '/homes/chirag/.imapfilter/options.lua'
dofile '/homes/chirag/.imapfilter/account.lua'

my_email ='chirag'

-- archive message not sent to me
results = jnpr.INBOX:select_all() - (jnpr.INBOX:contain_to(my_email) + jnpr.INBOX:contain_cc(my_email))
results:move_messages(jnpr[',mbox'])

-- archive old messages (older than 30 days) sent to me
-- results = jnpr.INBOX:is_older(30)
-- results:move_messages(jnpr[',mbox'])

