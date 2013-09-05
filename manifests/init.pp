define sshuser (
  	$ensure =  present,
	$username,
	$password,
	$home = "/home/$username",
	$managehome = false,
	$uid,
	$gid,
	#$groups,
	$fullname,
	$expiry = absent,
	$sshkey,
	
) {
	user { "$username":
		ensure => $ensure,
		password => $password,
		uid => $uid,
		gid => $gid,
		#groups => $groups,
		home => $home,
		managehome => $managehome,
		comment => "$fullname",
		shell => "/bin/bash",
		#expiry => $expiry
	}
	
	file { "$home/.ssh":
    		ensure => "directory",
    		mode   => 600,
    		owner  => $username,
    		group  => $gid,
  	}
	
	ssh_authorized_key { "$username":
		ensure => present,
		key => $sshkey,
		user    => $username,
                type    => "ssh-rsa",
	}	
}
