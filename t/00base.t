use Test::More tests => 14;

BEGIN { use_ok('File::Copy'); }

our $skip_www = 1;

&clear_testenv;
&make_testenv;

system("$^X uncpan testtmp/testtgz.tgz");
ok(-f "testtmp/testtgz/Makefile.PL", "uncpan testtmp/testtgz.tgz extract files ok");

system("$^X uncpan testtmp/testzip.zip");
ok(-f "testtmp/testzip/Makefile.PL", "uncpan testtmp/testzip.zip extract files ok");

system("$^X uncpan testtmp/nodir.tgz");
ok(-f "testtmp/nodir/Makefile.PL", "uncpan testtmp/nodir.tgz extract files ok");

system("$^X uncpan testtmp/badtar.tgz");
ok(-f "testtmp/badtar/Makefile.PL", "uncpan testtmp/badtar.tgz extract files ok");

system("$^X uncpan testtmp/badfile");
pass("uncpan testtmp/badfile");

&clear_testenv;
&make_testenv;

system("$^X uncpan testtmp");
ok(-f "testtmp/testtgz/Makefile.PL", "uncpan testtmp extract files ok");

&clear_testenv;

SKIP: {
	skip "www tests", 2 if $skip_www;

	mkdir("testdown");
	chdir("testdown");
	system("$^X ../uncpan http://www.cpan.org/authors/id/N/NE/NEDKONZ/Archive-Zip-1.09.tar.gz");
	ok(-f "Archive-Zip-1.09/Makefile.PL", "uncpan URL Archive-Zip-1.09.tar.gz");

	system("$^X ../uncpan Want");
	ok(-f "Want-0.07/Makefile.PL", "uncpan module Want");

	chdir("..");
};

sub make_testenv {
	mkdir "testtmp";
	copy("testcase/badfile", "testtmp/badfile");
	copy("testcase/badtar.tgz", "testtmp/badtar.tgz");
	copy("testcase/nodir.tgz", "testtmp/nodir.tgz");
	copy("testcase/testtgz.tgz", "testtmp/testtgz.tgz");
	copy("testcase/testzip.zip", "testtmp/testzip.zip");
	ok(
		-d "testtmp" &&
		-f "testtmp/badfile" &&
		-f "testtmp/badtar.tgz" &&
		-f "testtmp/nodir.tgz" &&
		-f "testtmp/testtgz.tgz" &&
		-f "testtmp/testzip.zip", "Make testtmp" );
}

sub clear_testenv {
	foreach ( qw(
		testtmp/badfile
		testtmp/badtar/Makefile.PL
		testtmp/badtar
		testtmp/badtar.tgz
		testtmp/nodir/Makefile.PL
		testtmp/nodir
		testtmp/nodir.tgz
		testtmp/testtgz/Makefile.PL
		testtmp/testtgz
		testtmp/testtgz.tgz
		testtmp/testzip/Makefile.PL
		testtmp/testzip
		testtmp/testzip.zip
		testtmp
	) ) {
		unlink $_ if -f $_;
		rmdir $_ if -d $_;
	}
	ok( not( -d "testtmp"), "clear testtmp" );
}

1;
__END__;