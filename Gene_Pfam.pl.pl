#FILE: Gene_pfam.pl
#AUTH: Xiaoping Liao (liao_xp@tib.cas.cn)
#DATE: Aug. 7th, 2017
#VERS: 1.0

##This script is prepared to get the pfam domains using Gene symbol.
###It uses the Pfam API to retrieve domains, and the UniProt REST API to translate HGNC Gene Symbols into Uniprot/SwissProt Accession number
###Command: Perl Gene_Pfam.pl POLD1 POLD1_domain.txt 

use strict;
use warnings;
use JSON qw( decode_json );
use LWP::Simple;
use URI::Escape;
use LWP::UserAgent;
use HTTP::Request::Common;


my $gene=$ARGV[0];
###Get the uniprot id
my $search="http://www.uniprot.org/uniprot/?query=$gene+AND+reviewed:yes+AND+organism:9606+AND+database:pfam+&sort=score&columns=id,entry+name,reviewed,genes,organism&format=tab";
my $search_result=get($search);
my @id=split /\n/,$search_result;
my %hash=();
for my $k (1..scalar(@id)-1){
    my @a=split /\s+/,$id[$k];
    my @b= split /\,/,$a[3];
    for my $j (@b){
        $hash{$j}=$a[0];
    }
}

my $uniprotid=$hash{$gene};

###Get the pfam domains in json format
my $esearch="http://pfam.xfam.org/protein/$uniprotid/graphic";
my $esearch_result=get($esearch);

###Json to table
my $output=$ARGV[1];
get_domain($esearch_result,$output);

sub get_domain{
    my $json = shift;
    my $OUT = shift;
    my $decoded = decode_json($esearch_result);
    my $region=$decoded->[0]{"regions"};
    open my $OUTPUT, '>'.$OUT or die;
    print $OUTPUT "Domian\tDescription\tStart\tEnd\n";
    for my $k (keys @$region){
        my $domain=$region->[$k]{'metadata'}{'identifier'};
        my $description=$region->[$k]{'metadata'}{'description'};
        my $start=$region->[$k]{'metadata'}{'start'};
        my $end=$region->[$k]{'metadata'}{'end'};
        print $OUTPUT "$domain\t$description\t$start\t$end\n";
    }
}