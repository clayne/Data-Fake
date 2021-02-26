use 5.008001;
use strict;
use warnings;
use Test::More 0.96;
use Test::Deep;

use Data::Fake::Text;

subtest 'fake_words' => sub {
    for my $i ( undef, 0 .. 5 ) {
        my @args = defined $i ? $i : ();
        my $got = fake_words(@args)->();
        ok( defined($got), "word is defined" );

        my $n = defined $i ? $i : 1;
        my $msg = "word list of length $n";
        $msg .= " (default)" unless defined $i;

        is( scalar split( / /, $got ), $n, $msg );
    }
};

subtest 'fake_sentences' => sub {
    for my $i ( undef, 0 .. 5 ) {
        my @args = defined $i ? $i : ();
        my $got = fake_sentences(@args)->();
        ok( defined($got), "sentence is defined" );

        my $n = defined $i ? $i : 1;
        my $msg = "sentence list of length $n";
        $msg .= " (default)" unless defined $i;

        my $count =()= ( $got =~ /\./g );
        is( $count, $n, $msg ) or diag $got;
    }
};

subtest 'fake_paragraphs' => sub {
    for my $i ( undef, 0 .. 5 ) {
        my @args = defined $i ? $i : ();
        my $got = fake_paragraphs(@args)->();
        ok( defined($got), "paragraph is defined" );

        my $n = defined $i ? ( $i == 0 ? 0 : 2 * $i - 1 ) : 1;
        my $msg = "paragraph list of length $n";
        $msg .= " (default)" unless defined $i;

        my $count = scalar split /^/, $got;
        is( $count, $n, $msg ) or diag $got;
    }
};

subtest 'scalar context' => sub {
    my @words = fake_words(2)->();
    is(scalar(@words), 1, "words");
    my @sentences = fake_sentences(2)->();
    is(scalar(@sentences), 1, "sentences");
    my @paragraphs = fake_paragraphs(2)->();
    is(scalar(@paragraphs), 1, "paragraphs");
};

done_testing;
# COPYRIGHT

# vim: ts=4 sts=4 sw=4 et tw=75:
