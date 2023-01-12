select auth::User {first_name, last_name, username}
filter .username = <str>$username