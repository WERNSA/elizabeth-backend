module auth {
    type User {
        required property first_name -> str;
        required property last_name -> str;
        required property username -> str{
            constraint exclusive;
            constraint min_len_value(4);
        }
        required property password -> str;
        required link role -> Role;
    }

    type Role {
        required property name -> str;
        required property description -> str;
    }
}