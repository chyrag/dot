-- the following is required if running in standalone mode
dofile '/homes/chirag/.imapfilter/options.lua'
dofile '/homes/chirag/.imapfilter/account.lua'

my_email = 'chirag@juniper.net'

-- Mailboxes
MB = jnpr[',mbox']
SCM = jnpr[',scm']
BUGS = jnpr[',bugs']
TECH = jnpr[',tech']
OLDPROJECTS = jnpr[',projects']
NONTECH = jnpr[',non-tech']
NEWS = jnpr[',news']
SALES = jnpr['sales']
REVIEWS = jnpr[',reviews']
CURRENT = jnpr[',current']
EXPENSES = jnpr['Expenses']
TEAM = jnpr[',team']

-- check if the MB exists and the status
MB:check_status()

-- First and foremost, the filters that would move out max number of emails.
-- Subsequent filters will have less mails to peek through to filter.

-- Dump svn mails to ,svn
result = MB:contain_subject('[svn-commit]')
	+ MB:contain_subject('cvs commit: ')
	+ MB:contain_subject('[svn-commit]')
result:move_messages(SCM)

result = MB:contain_to('bug-sw-all@juniper.net')
	+ MB:contain_cc('bug-sw-all@juniper.net')
	+ MB:contain_to('bug-sw-all')
	+ MB:contain_cc('bug-sw-all')
	+ MB:contain_to('bug-sw-chassisd@juniper.net')
	+ MB:contain_cc('bug-sw-chassisd@juniper.net')
	+ MB:contain_to('bug-sw-chassisd')
	+ MB:contain_cc('bug-sw-chassisd')
	+ MB:contain_to('bug-sw-chassisd-unix@juniper.net')
	+ MB:contain_cc('bug-sw-chassisd-unix@juniper.net')
	+ MB:contain_to('bug-sw-chassisd-unix')
	+ MB:contain_cc('bug-sw-chassisd-unix')
	+ MB:contain_subject('sw-chassisd/')
	+ MB:contain_subject('sw-belvedere/')
	+ MB:contain_subject('sw-hercules-pfe/')
	+ MB:contain_subject('sw-hercules-intf/')
	+ MB:contain_subject('sw-hercules-platform/')
	+ MB:contain_subject('sw-absolut/')
	+ MB:contain_subject('sw-re/')
	+ MB:contain_subject('cse-jflow/')
	+ MB:contain_subject('sw-intf-aggr-kern/')
	+ MB:contain_subject('esw-neo-mic/')
	+ MB:contain_subject('sw-pfe-tseries-ucast/')
	+ MB:contain_subject('sw-p2mp/')
	+ MB:contain_subject('sw-routing-infra/')
	+ MB:contain_subject('sw-routing-infra-ha/')
	+ MB:contain_subject('sw-routing-infra-if/')
	+ MB:contain_subject('sw-os-peer-infra/')
	+ MB:contain_subject('sw-atlas-chassisd/')
	+ MB:contain_subject('sw-chassisd-mx/')
	+ MB:contain_subject('sw-mpls-oam/')
	+ MB:contain_subject('sw-mpls/')
	+ MB:contain_subject('static-analysis-defects/')
	+ MB:contain_subject('bbe-smgd/')
	+ MB:contain_from('gnats')
result:move_messages(BUGS)

-- Dump mails from current project to CURRENT
result = MB:contain_to('CDBU TVP NG SW TEAM') +
	MB:contain_cc('CDBU TVP NG SW TEAM') +
	MB:contain_to('CDBU-TVP-NG-SW-TEAM') +
	MB:contain_cc('CDBU-TVP-NG-SW-TEAM')
result:move_messages(CURRENT)

-- Team notifications
result = MB:contain_to('madhu-direct')
	+ MB:contain_cc('madhu-direct')
	+ MB:contain_to('madhu-team')
	+ MB:contain_cc('madhu-team')
result:move_messages(TEAM)

-- Old projects
result = MB:contain_to('blossomhill-sw@juniper.net')
	+ MB:contain_cc('blossomhill-sw@juniper.net')
	+ MB:contain_to('blossomhill-sw')
	+ MB:contain_cc('blossomhill-sw')
	+ MB:contain_to('hercules-eng@juniper.net')
	+ MB:contain_cc('hercules-eng@juniper.net')
	+ MB:contain_to('hercules-eng')
	+ MB:contain_cc('hercules-eng')
	+ MB:contain_to('hercules-sw@juniper.net')
	+ MB:contain_cc('hercules-sw@juniper.net')
	+ MB:contain_to('hercules-sw')
	+ MB:contain_cc('hercules-sw')
	+ MB:contain_to('belvedere-eng@juniper.net')
	+ MB:contain_cc('belvedere-eng@juniper.net')
	+ MB:contain_to('belvedere-eng')
	+ MB:contain_cc('belvedere-eng')
result:move_messages(OLDPROJECTS)

-- Dump mails from news/internal-training to ,news
result = MB:contain_to('news')
result:move_messages(NEWS)

-- Dump mails from weekly-sales-update to ,news
result = MB:contain_from('Weekly-Sales-Update')
result:move_messages(SALES)

result = MB:contain_to('kernel-hackers@juniper.net')
	+ MB:contain_cc('kernel-hackers@juniper.net')
	+ MB:contain_to('kernel-hackers')
	+ MB:contain_cc('kernel-hackers')
	+ MB:contain_to('chassisd-hackers@juniper.net')
	+ MB:contain_cc('chassisd-hackers@juniper.net')
	+ MB:contain_to('chassisd-hackers')
	+ MB:contain_cc('chassisd-hackers')
result:move_messages(TECH)

-- Dump mails from *-review to ,reviews
result = MB:contain_to('kernel-review@juniper.net')
	+ MB:contain_cc('kernel-review@juniper.net')
	+ MB:contain_to('kernel-review')
	+ MB:contain_cc('kernel-review')
	+ MB:contain_to('platform-app-review@juniper.net')
	+ MB:contain_cc('platform-app-review@juniper.net')
	+ MB:contain_to('platform-app-review')
	+ MB:contain_cc('platform-app-review')
	+ MB:contain_to('issu-review@juniper.net')
	+ MB:contain_cc('issu-review@juniper.net')
	+ MB:contain_to('issu-review')
	+ MB:contain_cc('issu-review')
	+ MB:contain_to('chassisd-review@juniper.net')
	+ MB:contain_cc('chassisd-review@juniper.net')
	+ MB:contain_to('chassisd-review')
	+ MB:contain_cc('chassisd-review')
	+ MB:contain_to('ipg-chasd-master-review@juniper.net')
	+ MB:contain_cc('ipg-chasd-master-review@juniper.net')
	+ MB:contain_to('ipg-chasd-master-review')
	+ MB:contain_cc('ipg-chasd-master-review')
	+ MB:contain_to('ipg-chasd-re-review@juniper.net')
	+ MB:contain_cc('ipg-chasd-re-review@juniper.net')
	+ MB:contain_to('ipg-chasd-re-review')
	+ MB:contain_cc('ipg-chasd-re-review')
	+ MB:contain_to('ipg-chasd-cbu-review@juniper.net')
	+ MB:contain_cc('ipg-chasd-cbu-review@juniper.net')
	+ MB:contain_to('ipg-chasd-cbu-review')
	+ MB:contain_cc('ipg-chasd-cbu-review')
	+ MB:contain_to('kernel-noklock-review@juniper.net')
	+ MB:contain_cc('kernel-noklock-review@juniper.net')
	+ MB:contain_to('kernel-noklock-review')
	+ MB:contain_cc('kernel-noklock-review')
	+ MB:contain_to('issu-noklock-review@juniper.net')
	+ MB:contain_cc('issu-noklock-review@juniper.net')
	+ MB:contain_to('issu-noklock-review')
	+ MB:contain_cc('issu-noklock-review')
	+ MB:contain_to('platform-app-noklock-review@juniper.net')
	+ MB:contain_cc('platform-app-noklock-review@juniper.net')
	+ MB:contain_to('platform-app-noklock-review')
	+ MB:contain_cc('platform-app-noklock-review')
	+ MB:contain_subject('review-code')
	+ MB:contain_subject('Review Request ')
	+ MB:contain_subject('Review PR ')
result:move_messages(REVIEWS)

-- Dump mails from team, group, BU to ,non-tech
-- --filtertohdr (MB, 'prasad-dstaff',	    jnpr[',team'])
-- --filtertohdr (MB, 'ebi-dstaff',		    jnpr[',non-tech'])
-- --filtertohdr (MB, 'IPG-HSBU-sw-india',	    jnpr[',non-tech'])
-- --filtertohdr (MB, 'IPG-CBU-sw-india',	    jnpr[',non-tech'])
-- --filtertohdr (MB, 'IPG-HSBU-eng-india',	    jnpr[',non-tech'])
-- --filtertohdr (MB, 'IPG-CBU-eng-india',	    jnpr[',non-tech'])
-- --filtertohdr (MB, 'IPG-CBU-eng-sw',	    jnpr[',non-tech'])
-- --filtertohdr (MB, 'IPG-CBU-eng-sw2',	    jnpr[',non-tech'])
-- --filtertohdr (MB, 'IPG-CBU-All',	    jnpr[',non-tech'])
-- --filtertohdr (MB, 'Kernel-junoscore',	    jnpr[',non-tech'])
-- --filtertohdr (MB, 'kernel-bangalore',	    jnpr[',non-tech'])
-- --filtertohdr (MB, 'cbu-bng-fabric-platform',  jnpr[',non-tech'])
-- --filtertohdr (MB, 'gnats-info',		    jnpr[',non-tech'])
-- --
-- Dump matrix notifications to ,matrix
-- result = MB:contain_field('Return-Path', 'matrix-notifications@matrix.juniper.net')
-- result = MB:contain_field('Return-Path', 'bounce-matrix@juniper.net')

-- Dump mails to hercules-eng, starlifter-sw to ,projects
-- --filtertohdr (MB, 'hercules-eng',	    jnpr[',projects'])
-- --filtertohdr (MB, 'hercules-sw',	    jnpr[',projects'])
-- --filtertohdr (MB, 'starlifter-sw',	    jnpr[',projects'])
-- --filtertohdr (MB, 'galaxy-pfe',		    jnpr[',projects'])
-- --filtertohdr (MB, 'xfbringup',		    jnpr[',projects'])
-- --filtertohdr (MB, 'xm-bringup',		    jnpr[',projects'])
-- --filtertohdr (MB, 'Hercules-plat',	    jnpr[',projects'])
-- ---- Dump mails to provider-eng to ,projects
-- --filtertohdr (MB, 'provider-eng',		    jnpr[',projects'])
-- ---- Dump mails to belvedere-sw to ,belvedere-eng
-- --filtertohdr (MB, 'belvedere-eng',	    jnpr[',projects'])
-- --filtertohdr (MB, 'belvedere-sw',		    jnpr[',projects'])
-- ---- Dump mails to Multichassis-eng, multichassis-sw to ,projects
-- --filtertohdr (MB, 'Multichassis-eng',	    jnpr[',projects'])
-- --filtertohdr (MB, 'multichassis-sw',	    jnpr[',projects'])
-- --filtertohdr (MB, 'kern-whitebox-testing',    jnpr[',projects'])
-- --filtertohdr (MB, 'vmm-users',		    jnpr[',projects'])
-- ---- Dump mails to blossomhill project to ,projects
-- --filtertohdr (MB, 'blossomhill-sw',	    jnpr[',projects'])
-- --filterfrmhdr (MB, 'blossomhill-sw',	    jnpr[',projects'])
-- --filtertohdr (MB, 'blossomhill-npi',	    jnpr[',projects'])
-- --filtertohdr (MB, 'BlossomHill-NPI',	    jnpr[',projects'])
-- --
-- ---- Dump mails for current project (blossomhill) to ,current
-- ---- messages = filtertohdr (MB, '???',	    jnpr[',current'])
-- --
-- ---- Dump mails to android-users to ,tp list
-- --filtertohdr (MB, 'android-users',	jnpr[',tp'])
-- ---- Dump mails from linux-users to ,tp
-- --filtertohdr (MB, 'linux-users',		jnpr[',tp'])
-- ---- Dump mails from freebsd-trolls to ,tp
-- --filtertohdr (MB, 'freebsd-trolls',	jnpr[',tp'])
-- ---- Dump mails from j-cook to ,tp
-- --filtertohdr (MB, 'J-Cook',		jnpr[',tp'])
-- --
-- Dump mails from bangalore-misc to ,non-tech
result = MB:contain_to('Bangalore-misc@juniper.net')
	+ MB:contain_cc('Bangalore-misc@juniper.net')
	+ MB:contain_to('Bangalore-misc')
	+ MB:contain_cc('Bangalore-misc')
	+ MB:contain_to('JReaders-India@juniper.net')
	+ MB:contain_cc('JReaders-India@juniper.net')
	+ MB:contain_to('JReaders-India')
	+ MB:contain_cc('JReaders-India')
	+ MB:contain_field('From', 'matrix-notifications@matrixmail.juniper.net')
result:move_messages(NONTECH)

-- Expense messages
result = MB:contain_from('AutoNotification@concursolutions.com')
result:move_messages(EXPENSES)

-- Irritating out-of-office messages
result = MB:contain_subject('Out of Office:')
result:delete_messages()

-- Dump cuty mails to Deleted Items
result = MB:contain_from('cuty-admins')
result:delete_messages()

-- Delete mails from psg-cbu-dev-test
result = MB:contain_from('psg-cbu-dev-test')
	+ MB:match_subject('PSD Branch Status')
result:delete_messages()

-- Dump calendar invites to Calendar folder
-- result = MB:match_field('Content-class', 'urn:content-classes:calendarmessage')
-- result:move_messages(jnpr['Calendar'])
