class users {
    user {'user':
        ensure => 'present',
        managehome => true,
        # changeme
        password => '$6$xyz$9vc9yeDgngEirzYEeLZqCay8YLhc7JHmd1t2UYrjdm7dD0M6raCXz.xtEXBL4.aaRf26S/aKagS36D1iH7E79.',
        shell => '/bin/bash'
    }
}
