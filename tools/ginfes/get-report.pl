#!/usr/bin/perl

use LWP::Simple;
use LWP::UserAgent;
use HTML::Form;

# getting report page
my $html = get $ARGV[0];

# extracting form values
my @form = HTML::Form->parse( $html, $ARGV[0] );
my $nfs = $form[0]->value('nfs');

# obtendo o link do PDF
$ua = LWP::UserAgent->new();
my $res = $ua->post(
    'http://visualizar.ginfes.com.br/report/exportacao',
    [
        nfs           => $nfs,
        nomeRelatorio => 'nfs_sao_bernardo_campo_novo',
        imprime       => 0,
        tipo          => 'pdf'
    ]
);
my $address = $res->header('location');

# baixando o arquivo PDF
#my @path = split /\//, $address;
#getstore $address, $path[$#path];
getstore $address, $ARGV[1];

__END__

=head1 NAME

get-report :: ferramenta para download de notas Ginfs

=head1 SINOPSYS

    $ ./get-report.pl [url de visualizacao] [nome do arquivo]

    $ ./get-report.pl 'http://visualizar.ginfes.com.br/report/consultarNota?__report=nfs_sao_bernardo_campo_novo&cdVerificacao=00000000' arquivo.pdf

=head1 DESCRIPTION

Este script tem o objetivo de acessar a pagina destinada a visualização das notas fiscais 
emitidas pelo Ginfes e automatizar o processo de download das notas em formato PDF.

A ferramenta tem como objetivo apenas automatizar o processo de obteção dos arquivos em 
formato PDF e futuramente, pretende-se expandir o uso, permitindo arquivos do tipo DOC, XLS,
etc...

=head1 AUTHOR

2012 (c) Daniel Vinciguerra.

=cut
