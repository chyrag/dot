options.timeout = 120	
options.subscribe = true	
yahoo = IMAP {  
    server = 'imap.mail.yahoo.com',
    username = 'chyrag',
    password = 'xxxxxxxx',
    ssl = 'ssl3'
}

-- mailboxes
stash = yahoo['Stash']
jokes= yahoo['Jokes']
trash= yahoo['Trash']

-- check status of inbox
stash:check_status()

--
-- Delete junk mails
--
print "Deleting sweet jokes"
result = stash:contain_from('sweet_jokes@yahoogroups.com')
	+ stash:contain_subject(':::|Sweet Jokes')
result:delete_messages()

print "Deleting ChezLily jokes"
result = stash:contain_to('ChezLily@yahoogroups.com')
	+ stash:contain_subject('[ChezLily]')
	+ stash:contain_from('peggymalone@gmail.com')
	+ stash:contain_from('ZPTD00Dah@aol.com')
	+ stash:contain_from('BluezMama@gmail.com')
	+ stash:contain_from('BluezMama2@alepomsnuthouse.com')
	+ stash:contain_from('Sin2Enjoy@aol.com')
	+ stash:contain_from('lilytrueblue2@yahoo.com')
result:delete_messages()

print "Deleting xcigars"
result = stash:contain_subject('[xcigars]')
result:delete_messages()

--
-- Move jokes
--
print "Moving William Brabant's jokes"
result = stash:contain_from('bbrabant@sault.com')
	+ stash:contain_from('William Brabant')
	+ stash:contain_subject('[buffalos-adult-chips]')
result:move_messages(jokes)

print "Moving Stellacious jokes"
result = stash:contain_from('stellacious@aol.com')
result:move_messages(jokes)

print "Moving Rotten jokes"
result = stash:contain_to('rotten_jokes@yahoogroups.com')
	+ stash:contain_subject('[rotten_jokes]')
result:move_messages(jokes)

print "Moving Stupid jokes"
result = stash:contain_to('STUPIDJOKE@yahoogroups.com')
	+ stash:contain_subject('[STUPIDJOKE]')
result:move_messages(jokes)

print "Moving NuthinButNet jokes"
result = stash:contain_to('nuthinbutnet@yahoogroups.com')
	+ stash:contain_from('XgmnirisingX@aol.com')
	+ stash:contain_subject('[NuthinbutNet]')
result:move_messages(jokes)

print "Dyan's Fun Ezines"
result = stash:contain_to('Funzines-AdultJokes@yahoogroups.com')
result:move_messages(jokes)

print "Stan Kegel's jokes"
result = stash:contain_from('skegel@socal.rr.com')
result:move_messages(jokes)

print "Moving Joanna's jokes"
result = stash:contain_to('JoannasJokes@yahoogroups.com')
	+ stash:contain_subject('[JoannasJokes]')
result:move_messages(jokes)

print "Moving Over the Edge jokes"
result = stash:contain_to('OverTheEdge-post-thorn@Topica.com')
	+ stash:contain_subject('[Over The Edge]')
result:move_messages(jokes)

print "Internet Oracle"
result = stash:contain_to('oracle-list@cs.indiana.edu')
result:move_messages(jokes)

print "Emptying trash"
result = trash:is_undeleted()
result:delete_messages()

-- check status of inbox
stash:check_status()
