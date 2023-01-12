module models {
    type Task {
        required property name -> str;
        required property description -> str;
        required property hour_limit -> cal::local_time;
        required property is_daily -> bool;
        property day -> array<int32>; # 0 monday - 6 sunday
        required link assigned_to -> auth::User;
    }
    type TaskFinished {
        required link task -> Task;
        required property finished_at -> cal::local_datetime;
        required property is_done -> bool;
        required property comments -> str;
        required link finished_by -> auth::User;
    }
}