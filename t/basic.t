use strict;
use warnings;
use Test::More 'no_plan';

our ($id, @stashes);

BEGIN { use_ok('B::Hooks::OP::Check::StashChange'); }

BEGIN {
    $id = B::Hooks::OP::Check::StashChange::register(sub {
        push @stashes, [@_];
    });
}

package Foo;

package Bar;

BEGIN {
    B::Hooks::OP::Check::StashChange::unregister($id);
}

package main;

is_deeply(
    \@stashes,
    [[ main => undef  ],
     [ Foo  => 'main' ],
     [ Bar  => 'Foo'  ]]
);
