class { 'mysql::server':
  override_options => {
    mysqld => {
      innodb_file_format    => 'barracuda',
      innodb_file_per_table => 1,
      innodb_large_prefix   => 1,
    },
  },
}

mysql::db { 'icingadb':
  charset  => 'utf8',
  collate  => 'utf8_general_ci',
  user     => 'icingadb',
  password => Sensitive('supersecret'),
  host     => 'localhost',
  grant    => ['ALL'],
}

class { 'icingadb::redis':
  manage_repos => true,
  requirepass  => Sensitive('supersecret'),
}

class { 'icingadb':
  db_password    => Sensitive('supersecret'),
  redis_password => Sensitive('supersecret'),
  import_schema  => true,
  require        => Mysql::Db['icingadb'],
}
