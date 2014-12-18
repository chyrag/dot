dofile '/homes/chirag/.imapfilter/options.lua'
dofile '/homes/chirag/.imapfilter/account.lua'

-- Use the following if we want to imapfilter to filter mails once and exit
-- dofile '/homes/chirag/.imapfilter/filters.lua'

-- Use the following if we want to imapfilter to go into infinite loop waiting
-- for new mails to filter
-- while true do
-- 	dofile '/homes/chirag/.imapfilter/filters.lua'
-- 	jnpr.INBOX:enter_idle()
-- 	-- jnpr.INBOX:check_status()
-- end

-- Misc
-- dofile '/homes/chirag/.imapfilter/function.lua'
-- jnpr.INBOX:check_status()

-- -- At the end of the day, move the seen messages to Received-`date +%Y%m`
-- -- result = jnpr.INBOX:is_seen()
-- -- if (result ~= nil) then
-- --     received = 'Received-' .. os.date('%Y') .. '-' .. os.date('%m')
-- --     jnpr.INBOX:move_messages(jnpr[received], result)
-- -- end
-- 
-- -- Get the status of a mailbox
-- jnpr.INBOX:check_status()

-- archive mails (currently, mails that are older than 30 days, and mails that
-- were not sent to me directly - eg, sent to aliases) are archived
-- dofile '/homes/chirag/.imapfilter/archive.lua'

-- sort the mails moved to ,mbox folder
-- dofile '/homes/chirag/.imapfilter/newfilters.lua'

-- jnpr.INBOX:check_status()
