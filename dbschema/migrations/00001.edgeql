CREATE MIGRATION m1ohkmoyyvhai2golov5imbzhvh7fymjsnycyqxtdom7yebxa6fdwa
    ONTO initial
{
  CREATE MODULE auth IF NOT EXISTS;
  CREATE MODULE models IF NOT EXISTS;
  CREATE TYPE auth::Role {
      CREATE REQUIRED PROPERTY description -> std::str;
      CREATE REQUIRED PROPERTY name -> std::str;
  };
  CREATE TYPE auth::User {
      CREATE REQUIRED LINK role -> auth::Role;
      CREATE REQUIRED PROPERTY first_name -> std::str;
      CREATE REQUIRED PROPERTY last_name -> std::str;
      CREATE REQUIRED PROPERTY password -> std::str;
      CREATE REQUIRED PROPERTY username -> std::str {
          CREATE CONSTRAINT std::exclusive;
          CREATE CONSTRAINT std::min_len_value(4);
      };
  };
  CREATE TYPE models::Task {
      CREATE PROPERTY day -> array<std::int32>;
      CREATE REQUIRED LINK assigned_to -> auth::User;
      CREATE REQUIRED PROPERTY description -> std::str;
      CREATE REQUIRED PROPERTY hour_limit -> cal::local_time;
      CREATE REQUIRED PROPERTY is_daily -> std::bool;
      CREATE REQUIRED PROPERTY name -> std::str;
  };
  CREATE FUTURE nonrecursive_access_policies;
  CREATE TYPE models::TaskFinished {
      CREATE REQUIRED LINK finished_by -> auth::User;
      CREATE REQUIRED LINK task -> models::Task;
      CREATE REQUIRED PROPERTY comments -> std::str;
      CREATE REQUIRED PROPERTY finished_at -> cal::local_datetime;
      CREATE REQUIRED PROPERTY is_done -> std::bool;
  };
};
