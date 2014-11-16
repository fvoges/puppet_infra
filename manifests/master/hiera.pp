class puppet_infra::master::hiera (
    $hiera_base = $puppet_infra::params::hiera_base,
    $hiera_backends = $puppet_infra::params::hiera_backends,
    $hiera_hierarchy = $puppet_infra::params::hiera_hierarchy,
    $hiera_template = $puppet_infra::params::hiera_template,

) inherits  puppet_infra::params
{
    
    validate_absolute_path($hiera_base)
    validate_array($hiera_backends)
    validate_array($hiera_hierarchy)
    validate_string($hiera_template)

    file {"${::settings::confdir}/hiera.yaml":
            ensure => file,
            owner => "root",
            group => "root",
            mode => "0644",
            content => template($hiera_template),
    }
    
}

