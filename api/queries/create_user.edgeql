select (insert auth::User {
    first_name := <str>$first_name,
    last_name := <str>$last_name,
    username := <str>$username,
    password := <str>$password,
    role := assert_single((select auth::Role filter .id = <uuid>$role_id))
}) {
    username,
    first_name,
    last_name
};