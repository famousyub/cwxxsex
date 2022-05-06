use HTTP::Proxy;

# initialisation
my $proxy = HTTP::Proxy->new( port => 3128 );

# alternate initialisation
my $proxy = HTTP::Proxy->new;
$proxy->port( 3128 ); # the classical accessors are here!

# this is a MainLoop-like method
$proxy->start;
