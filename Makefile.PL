use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'			=> 'uncpan',
    'VERSION_FROM'	=> 'uncpan', # finds $VERSION
	'EXE_FILES'		=> [ 'uncpan' ],
    'PREREQ_PM'		=> {
    		Getopt::Std,
    		IO::Dir,
    		File::Spec,
    		File::Basename,
    		Archive::Tar,
    		Archive::Zip,
    	}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'uncpan', # retrieve abstract from module
       AUTHOR     => 'Qing-Jie Zhou <qjzhou@hotmail.com>') : ()),
);