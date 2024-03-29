#!/usr/bin/env perl
use strict;
use warnings;

use Test::More tests => 41;
use_ok('Class::AutoGenerate');

package My::ClassLoader;
use Class::AutoGenerate -base;

requiring '**' => generates {};

package main;

my $class_loader1 = My::ClassLoader->new( match_only => 'Prefix1::**' );
my $class_loader2 = My::ClassLoader->new( match_only => 'Prefix2::**' );

isa_ok($class_loader1, 'Class::AutoGenerate');
isa_ok($class_loader2, 'Class::AutoGenerate');

require_ok('Prefix1::Thing');
require_ok('Prefix2::Thing');

ok(Class::AutoGenerate::autogenerated('Prefix1::Thing'));
ok(Class::AutoGenerate::autogenerated('Prefix2::Thing'));
ok(!Class::AutoGenerate::autogenerated('Prefix3::Thing'));

ok(Class::AutoGenerate->autogenerated('Prefix1::Thing'));
ok(Class::AutoGenerate->autogenerated('Prefix2::Thing'));
ok(!Class::AutoGenerate->autogenerated('Prefix3::Thing'));

ok(My::ClassLoader::autogenerated('Prefix1::Thing'));
ok(My::ClassLoader::autogenerated('Prefix2::Thing'));
ok(!My::ClassLoader::autogenerated('Prefix3::Thing'));

ok(My::ClassLoader->autogenerated('Prefix1::Thing'));
ok(My::ClassLoader->autogenerated('Prefix2::Thing'));
ok(!My::ClassLoader->autogenerated('Prefix3::Thing'));

ok($class_loader1->autogenerated('Prefix1::Thing'));
ok($class_loader1->autogenerated('Prefix2::Thing'));
ok(!$class_loader1->autogenerated('Prefix3::Thing'));

ok($class_loader2->autogenerated('Prefix1::Thing'));
ok($class_loader2->autogenerated('Prefix2::Thing'));
ok(!$class_loader2->autogenerated('Prefix3::Thing'));

is(Class::AutoGenerate::autogenerator_of('Prefix1::Thing'), $class_loader1);
is(Class::AutoGenerate::autogenerator_of('Prefix2::Thing'), $class_loader2);
is(Class::AutoGenerate::autogenerator_of('Prefix3::Thing'), undef);

is(Class::AutoGenerate->autogenerator_of('Prefix1::Thing'), $class_loader1);
is(Class::AutoGenerate->autogenerator_of('Prefix2::Thing'), $class_loader2);
is(Class::AutoGenerate->autogenerator_of('Prefix3::Thing'), undef);

is(My::ClassLoader::autogenerator_of('Prefix1::Thing'), $class_loader1);
is(My::ClassLoader::autogenerator_of('Prefix2::Thing'), $class_loader2);
is(My::ClassLoader::autogenerator_of('Prefix3::Thing'), undef);

is(My::ClassLoader->autogenerator_of('Prefix1::Thing'), $class_loader1);
is(My::ClassLoader->autogenerator_of('Prefix2::Thing'), $class_loader2);
is(My::ClassLoader->autogenerator_of('Prefix3::Thing'), undef);

is($class_loader1->autogenerator_of('Prefix1::Thing'), $class_loader1);
is($class_loader1->autogenerator_of('Prefix2::Thing'), $class_loader2);
is($class_loader1->autogenerator_of('Prefix3::Thing'), undef);

is($class_loader2->autogenerator_of('Prefix1::Thing'), $class_loader1);
is($class_loader2->autogenerator_of('Prefix2::Thing'), $class_loader2);
is($class_loader2->autogenerator_of('Prefix3::Thing'), undef);
