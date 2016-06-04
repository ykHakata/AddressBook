#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }
BEGIN { unshift @INC, "$FindBin::Bin/../local/lib/perl5" }

# Start command line interface for application
require Mojolicious::Commands;
Mojolicious::Commands->start_app('AddressBook');
