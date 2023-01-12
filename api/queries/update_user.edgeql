select (
    update auth::User filter .username = <str>$username
        set {
            first_name := <str>$first_name,
            last_name := <str>$last_name,
            role := assert_single((select auth::Role filter .id = <uuid>$role_id))
        }
) {
    first_name,
    last_name
};