$password = Sensitive('icingadb')

class { 'icingadb':
  manage_repos           => true,
  db_type                => 'pgsql',
  db_host                => '192.168.5.13',
  db_password            => $password,
  redis_password         => 'redis',
  import_db_schema       => false,
}
