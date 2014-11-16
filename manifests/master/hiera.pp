class puppet_infra::master::hiera (
    $hiera_base = puppet_infra::params::hiera_base,
    $hiera_backends = puppet_infra::params::hiera_backends,
    $hiera_hieararchy = puppet_infra::params::hiera_hieararchy,
) inherits  puppet_infra::params
{
    
    validate_absolute_path($hiera_base)
    validate_array($hiera_backends)
    validate_array($hiera_hieararchy)

    file {"${::settings::confdir}/hiera.yaml":
            ensure => file,
            user => "root",
            group => "root",
            mode => "0644",
            content => template($hiera_template),
    }
    
}

