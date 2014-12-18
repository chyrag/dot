dofile '/homes/chirag/.imapfilter/options.lua'
dofile '/homes/chirag/.imapfilter/account.lua'

-- MB = jnpr.mbox
MB = jnpr[',mbox']

-- commit mails
scm = (
	MB:contain_to('cvs-all') +
	MB:contain_to('cvs-sw-projects') +
	MB:contain_to('svn-changes')
)
scm:move_messages(jnpr[',scm'])

-- review aliases
reviews = (
        MB:contain_to('chassisd-review') +
        MB:contain_to('issu-review') +
        MB:contain_to('kernel-review') +
        MB:contain_to('platform-app-review') +
        MB:contain_to('issu-other-noklock-review') +
        MB:contain_to('kernel-noklock-review') +
        MB:contain_to('platform-app-noklock-review') +
        MB:contain_to('issu-review') +
        MB:contain_to('ipmitool-review') +
        MB:contain_to('ipg-chasd-master-review') +
        MB:contain_to('ipg-chasd-re-review') +
        MB:contain_to('ipg-chasd-cbu-review')
)
reviews:move_messages(jnpr[',reviews'])

-- misc (non-tech) aliases
misc = (
        MB:contain_to('bangalore-misc') + MB:contain_from('bangalore-misc')
)
misc:move_messages(jnpr[',non-tech'])

-- gnats notifications
gnats = (
	MB:contain_to('bug-sw-all') +
	MB:contain_to('bug-sw-re') +
	MB:contain_to('bug-sw-redundancy') +
	MB:contain_to('bug-sw-kern-misc') +
	MB:contain_to('bug-sw-chassisd') +
	MB:contain_to('bug-sw-issu-infra')
)
gnats:move_messages(jnpr[',bugs'])

-- news
news = (
	MB:contain_to('news') +
	MB:contain_to('internal-training-bbl-all') +
	MB:contain_to('employees') +
	MB:contain_to('employees-nonemployees') +
	MB:contain_to('eng-bbl') +
	MB:contain_to('juniper-university-program-interests') +
	MB:contain_to('India-Facilities')
)
news:move_messages(jnpr[',news'])

-- tech
tech = (
	MB:contain_to('kernel-hackers') +
	MB:contain_to('chassisd-hackers')
)
tech:move_messages(jnpr[',tech'])
