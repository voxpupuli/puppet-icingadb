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
  user     => 'icingadb',
  password => 'supersecret',
  host     => 'localhost',
  grant    => [ 'ALL' ],
}

class { 'icingadb':
  manage_repo      => true,
  db_password      => 'supersecret',
  import_db_schema => true,
  require          => Mysql::Db['icingadb'],
}
