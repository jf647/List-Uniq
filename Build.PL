#
# $Id$
#

use Module::Build;

Module::Build->new(

    module_name        => 'List::Uniq',
    dist_version_from  => 'lib/List/Uniq.pm',
    license            => 'perl',
    create_makefile_pl => 'traditional',
    create_readme      => 1,

)->create_build_script;

#
# EOF
