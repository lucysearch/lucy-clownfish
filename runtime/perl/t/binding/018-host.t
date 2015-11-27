# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

use strict;
use warnings;

use Test::More tests => 5;
use Clownfish qw( to_clownfish );

my %complex_data_structure = (
    a => [ 1, 2, 3, { ooga => 'booga' } ],
    b => { foo => 'foofoo', bar => 'barbar' },
);
my $kobj = to_clownfish( \%complex_data_structure );
isa_ok( $kobj, 'Clownfish::Obj' );
my $transformed = $kobj->to_perl;
is_deeply( $transformed, \%complex_data_structure,
    "transform from Perl to Clownfish data structures and back" );

my $bread_and_butter = Clownfish::Hash->new;
$bread_and_butter->store( 'bread', Clownfish::Blob->new('butter') );
my $salt_and_pepper = Clownfish::Hash->new;
$salt_and_pepper->store( 'salt', Clownfish::ByteBuf->new('pepper') );
$complex_data_structure{c} = $bread_and_butter;
$complex_data_structure{d} = $salt_and_pepper;
$transformed = to_clownfish( \%complex_data_structure )->to_perl;
$complex_data_structure{c} = { bread => 'butter' };
$complex_data_structure{d} = { salt  => 'pepper' };
is_deeply( $transformed, \%complex_data_structure,
    "handle mixed data structure correctly" );

my $string = Clownfish::String->new("string");
eval { $string->substring(offset => 0, len => 1, foo => 1) };
like( $@, qr/Invalid parameter/, "Die on invalid parameter" );

eval { $string->length(undef) };
like( $@, qr/Usage: length/, "Die on extra parameter" );
