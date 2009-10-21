use inc::Module::Install;

name 'MouseX-App-Cmd';

all_from 'lib/MouseX/App/Cmd.pm';

test_requires 'Test::More';
test_requires 'Test::Output';

requires 'App::Cmd'       => 0.3;
requires 'Mouse'          => 0.39;
requires 'MouseX::Getopt' => 0.22;
requires 'Getopt::Long::Descriptive';

use_test_base;

tests 't/*.t';

auto_include;

WriteAll;
