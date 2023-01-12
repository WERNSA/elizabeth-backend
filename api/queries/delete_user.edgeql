select (
    delete auth::User filter .username = <str>$username
) {username};