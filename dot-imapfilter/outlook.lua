-- we are currently tracking only kern-misc and chassisd bugs
messages = filtertohdr (jnprmail.INBOX, 'bug-sw-all', jnprmail[',bugs'])
messages = filtertohdr (jnprmail.INBOX, 'bug-sw-kern-misc', jnprmail[',bugs'])
messages = filtertohdr (jnprmail.INBOX, 'bug-sw-chassisd', jnprmail[',bugs'])
messages = filtertohdr (jnprmail.INBOX, 'bug-sw-re', jnprmail[',bugs'])
messages = filtertohdr (jnprmail.INBOX, 'bug-esw-all', jnprmail[',bugs'])
messages = filtertohdr (jnprmail.INBOX, 'bug-sw-issu-infra', jnprmail[',bugs'])

-- Dump mails from news/internal-training to ,news
messages = filtertohdr (jnprmail.INBOX, 'internal-training-bbl-all', jnprmail[',news'])
messages = filtertohdr (jnprmail.INBOX, 'employees-nonemployees', jnprmail[',news'])
messages = filtertohdr (jnprmail.INBOX, 'employees', jnprmail[',news'])
messages = filtertohdr (jnprmail.INBOX, 'eng-bbl-all', jnprmail[',news'])
messages = filtertohdr (jnprmail.INBOX, 'juniper-university-program-interests', jnprmail[',news'])
messages = filtertohdr (jnprmail.INBOX, 'India-Facilities', jnprmail[',news'])
result = jnprmail.INBOX:contain_subject('J-Talk Asia')
if (result ~= nil) then
    jnprmail.INBOX:move_messages(jnprmail[',news'], result)
    jnprmail.INBOX:unmark_seen(result)
end
messages = filterfrmhdr (jnprmail.INBOX, 'IT-Communication', jnprmail[',news'])
messages = filterfrmhdr (jnprmail.INBOX, 'employeecomm', jnprmail[',news'])
messages = filtertohdr (jnprmail.INBOX, 'India-IT', jnprmail[',news'])
messages = filtertohdr (jnprmail.INBOX, 'ipg-all', jnprmail[',news'])
messages = filtertohdr (jnprmail.INBOX, 'IPG-All', jnprmail[',news'])
messages = filtertohdr (jnprmail.INBOX, 'IPG-India2', jnprmail[',news'])
messages = filtertohdr (jnprmail.INBOX, 'users-bng', jnprmail[',news'])
messages = filtertohdr (jnprmail.INBOX, 'Embassyprime', jnprmail[',news'])

-- Dump mails to junos-india-hackers to ,junos-india-hackers
messages = filtertohdr (jnprmail.INBOX, 'junos-india-hackers', jnprmail[',junos-india-hackers'])

-- Dump mails to replicant-coders to replicant-coders
messages = filtertohdr (jnprmail.INBOX, 'replicant-coders', jnprmail['replicant-coders'])
-- Dump mails from *-review to ,reviews
messages = filtertohdr (jnprmail.INBOX, 'chassisd-review', jnprmail[',reviews'])

-- Dump mails from issu-platform to ,issu-platform
messages = filtertohdr (jnprmail.INBOX, 'issu-platform', jnprmail[',issu-platform'])

-- Dump mails from kernel-hackers to ,kernel-hackers
-- Dump mails from re-hackers to ,kernel-hackers
messages = filtertohdr (jnprmail.INBOX, 'kernel-hackers', jnprmail[',kernel-hackers'])
messages = filtertohdr (jnprmail.INBOX, 're-hackers', jnprmail[',kernel-hackers'])

-- Dump mails from chassisd-hackers to ,chassisd-hackers
messages = filtertohdr (jnprmail.INBOX, 'chassisd-hackers', jnprmail[',chassisd-hackers'])

-- Dump mails from IPG-HSBU-sw-india to ,IPG-HSBU-sw-india
-- Dump mails from IPG-HSBU-eng-india to ,IPG-HSBU-sw-india
messages = filtertohdr (jnprmail.INBOX, 'IPG-HSBU-sw-india', jnprmail[',IPG-HSBU-sw-india'])
messages = filtertohdr (jnprmail.INBOX, 'IPG-HSBU-eng-india', jnprmail[',IPG-CBU-sw-india'])

messages = filtertohdr (jnprmail.INBOX, 'starlifter-sw', jnprmail[',hercules-eng'])
messages = filtertohdr (jnprmail.INBOX, 'galaxy-pfe', jnprmail[',hercules-eng'])
messages = filtertohdr (jnprmail.INBOX, 'xfbringup', jnprmail[',hercules-eng'])
messages = filtertohdr (jnprmail.INBOX, 'xm-bringup', jnprmail[',hercules-eng'])

-- Dump mails to provider-eng to ,provider-eng
messages = filtertohdr (jnprmail.INBOX, 'provider-eng', jnprmail[',provider-eng'])

-- Dump mails to Multichassis-eng, multichassis-sw to ,belvedere-eng
messages = filtertohdr (jnprmail.INBOX, 'Multichassis-eng', jnprmail[',belvedere-eng'])
messages = filtertohdr (jnprmail.INBOX, 'multichassis-sw', jnprmail[',belvedere-eng'])

