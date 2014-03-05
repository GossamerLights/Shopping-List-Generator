#!/usr/bin/perl
use warnings;
use strict;

print "Enter meal you want to make ";
my $name = <STDIN>;
chomp($name);

open RECIPIE, "/home/mattie/Documents/Recipies/$name.csv" or die "Recipie not found because $!\n";

my %ingrediants;
my @item;
my %totals;
shopping();

sub shopping {
	while (<RECIPIE>) {
		@item = split(",",$_);
		chomp($item[1]);
		$ingrediants{$item[0]} = $item[1];
		$totals{$item[0]} += $item[1];
	}
	close RECIPIE;
	another();
}


sub another {
	print "Do you want to make anything else? ";
	my $response = <STDIN>;
	chomp($response);

	if ($response =~ /^y/i) {
		print "Enter meal you want to make ";
		my $name = <STDIN>;
		chomp($name);

		open RECIPIE, "/home/mattie/Documents/Recipies/$name.csv" or die "Recipie not found because $!\n";
		shopping();
	} else {
		open SHOPPINGLIST, ">/home/mattie/Documents/Recipies/Shopping_List.txt" or die "Shopping_List not created because $!\n";
		foreach my $key (keys %totals) {
			print SHOPPINGLIST "$totals{$key}\t$key \n";
			
		}

		close SHOPPINGLIST;

	}
}




